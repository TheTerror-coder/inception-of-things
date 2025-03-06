#!/bin/sh -e

export SERVER_NODE_HOME="/home/vagrant"
export INSTALL_K3S_EXEC="server --debug --log '/tmp/k3s.log' --cluster-init --flannel-iface eth1 --write-kubeconfig-mode '0644'"
cat $SERVER_NODE_HOME/.bashrc | grep --quiet 'export SERVER_NODE_HOME' || echo "export SERVER_NODE_HOME=$SERVER_NODE_HOME" >> $SERVER_NODE_HOME/.bashrc
cat $SERVER_NODE_HOME/.bashrc | grep --quiet 'export KUBECONFIG' || echo "export KUBECONFIG='/etc/rancher/k3s/k3s.yaml'" >> $SERVER_NODE_HOME/.bashrc
cat $SERVER_NODE_HOME/.bashrc | grep --quiet 'source <(kubectl completion bash)' || echo "source <(kubectl completion bash)" >> $SERVER_NODE_HOME/.bashrc
cat $SERVER_NODE_HOME/.bashrc | grep --quiet "alias k='kubectl'" || echo "alias k='kubectl'" >> $SERVER_NODE_HOME/.bashrc
sudo apt update && sudo apt install -y curl vim
curl -sfL https://get.k3s.io | sh -
until kubectl version 2> /dev/null | grep --no-messages 'Server Version: v'; do sleep 1; done
until kubectl get serviceaccount default -n default 2> /dev/null | grep --quiet 'default' && echo 'serviceaccount "default" is found'; do sleep 1; done
kubectl apply -f $SERVER_NODE_HOME/iot-deployment-app-one.yaml && \
kubectl apply -f $SERVER_NODE_HOME/iot-service.yaml && \
kubectl apply -f $SERVER_NODE_HOME/iot-ingress.yaml