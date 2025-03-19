#!/bin/bash -e

source $SSL_SH

make-argocd-ssl-certificates
k3d cluster create --config $CLUSTER_CONFIG_FILES
until kubectl version 2> /dev/null | grep --no-messages 'Server Version: v'; do sleep 1; done
until kubectl get serviceaccount default -n default 2> /dev/null | grep --quiet 'default' && echo 'serviceaccount "default" is found'; do sleep 1; done
echo "installing nginx ingress controller..."
helm upgrade --install ingress-nginx ingress-nginx \
  --repo https://kubernetes.github.io/ingress-nginx \
  --namespace ingress-nginx --create-namespace | grep -i "STATUS: deployed" || (echo ingress-nginx installation failed!!! && exit 1)
echo "ingress-nginx installed!"

kubectl create namespace dev
kubectl create namespace argocd

kubectl apply -f $MANIFESTS_DIR/app/iot-deployment-app.yaml --wait
kubectl apply -f $MANIFESTS_DIR/app/iot-service-app.yaml --wait

kubectl apply -f $MANIFESTS_DIR/app-one/iot-deployment-app-one.yaml --wait
kubectl apply -f $MANIFESTS_DIR/app-one/iot-service-app-one.yaml --wait

kubectl apply -f $MANIFESTS_DIR/app-two/iot-deployment-app-two.yaml --wait
kubectl apply -f $MANIFESTS_DIR/app-two/iot-service-app-two.yaml --wait

kubectl apply -f $MANIFESTS_DIR/app-three/iot-deployment-app-three.yaml --wait
kubectl apply -f $MANIFESTS_DIR/app-three/iot-service-app-three.yaml --wait

kubectl wait deployment ingress-nginx-controller -n ingress-nginx --for=condition=available --timeout=60s
kubectl apply -f $MANIFESTS_DIR/ingress/iot-ingress.yaml --wait

kubectl create -n argocd secret tls argocd-server-tls --cert=ssl/argocd.crt --key=ssl/argocd.key
kubectl create -n argocd secret tls argocd-repo-server-tls --cert=ssl/argocd.crt --key=ssl/argocd.key
kubectl create -n argocd secret tls argocd-dex-server-tls --cert=ssl/argocd.crt --key=ssl/argocd.key

kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl apply -f $MANIFESTS_DIR/ingress/argocd-ingress.yaml --wait

kubectl wait deployment argocd-applicationset-controller -n argocd --for=condition=available --timeout=60s
kubectl wait deployment argocd-server -n argocd --for=condition=available --timeout=60s
kubectl wait deployment argocd-dex-server -n argocd --for=condition=available --timeout=60s
kubectl wait deployment argocd-repo-server -n argocd --for=condition=available --timeout=60s

initial_password=$(argocd admin initial-password -n argocd | awk 'NR == 1 { print $1 }' | tr -d [:blank:])
argocd login argocd.com:1443 --grpc-web --insecure --username admin --password $initial_password && \
argocd account update-password --server argocd.com:1443 --grpc-web --insecure --current-password $initial_password --new-password $ARGOCD_ACCOUNT_PASSWORD && \

argocd app create guestbook --repo https://github.com/argoproj/argocd-example-apps.git --path guestbook --dest-server https://kubernetes.default.svc --dest-namespace dev && \
argocd app create main-app --repo https://github.com/TheTerror-coder/inception-of-things.git --path p3/manifests/app --dest-server https://kubernetes.default.svc --dest-namespace dev --sync-policy auto --self-heal && \
argocd app create app-one --repo https://github.com/TheTerror-coder/inception-of-things.git --path p3/manifests/app-one --dest-server https://kubernetes.default.svc --dest-namespace dev --sync-policy auto --self-heal && \
argocd app create app-two --repo https://github.com/TheTerror-coder/inception-of-things.git --path p3/manifests/app-two --dest-server https://kubernetes.default.svc --dest-namespace dev --sync-policy auto --self-heal && \
argocd app create app-three --repo https://github.com/TheTerror-coder/inception-of-things.git --path p3/manifests/app-three --dest-server https://kubernetes.default.svc --dest-namespace dev --sync-policy auto --self-heal && \
sudo argocd app sync guestbook