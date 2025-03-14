#!/bin/bash -e

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
kubectl apply -f $MANIFESTS_DIR/iot-deployment-app.yaml --wait
kubectl apply -f $MANIFESTS_DIR/iot-deployment-app-one.yaml --wait
kubectl apply -f $MANIFESTS_DIR/iot-deployment-app-two.yaml --wait
kubectl apply -f $MANIFESTS_DIR/iot-deployment-app-three.yaml --wait
kubectl apply -f $MANIFESTS_DIR/iot-service-app.yaml --wait
kubectl apply -f $MANIFESTS_DIR/iot-service-app-one.yaml --wait
kubectl apply -f $MANIFESTS_DIR/iot-service-app-two.yaml --wait
kubectl apply -f $MANIFESTS_DIR/iot-service-app-three.yaml --wait
kubectl wait deployment ingress-nginx-controller -n ingress-nginx --for=condition=available --timeout=60s
kubectl apply -f $MANIFESTS_DIR/iot-ingress.yaml --wait
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
# kubectl create -n argocd secret tls argocd-server-tls --cert=/path/to/cert.pem --key=/path/to/key.pem
kubectl apply -f $MANIFESTS_DIR/argocd-ingress.yaml --wait