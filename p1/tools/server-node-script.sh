#!/bin/sh -e

echo SERVER_NODE_HOME: $SERVER_NODE_HOME
# sudo mkdir -p /etc/rancher/k3s/
# sudo mv /tmp/config.yaml $K3S_CONFIG_FILE
# echo "export K3S_CONFIG_FILE=$K3S_CONFIG_FILE" >> $SERVER_NODE_HOME/.bashrc
export INSTALL_K3S_EXEC="server --debug --log '/tmp/k3s.log' --cluster-init --flannel-backend vxlan --node-ip $SERVER_ETH1_IP --write-kubeconfig-mode '0644'"
# echo "export INSTALL_K3S_EXEC='$INSTALL_K3S_EXEC'" >> $SERVER_NODE_HOME/.bashrc
echo "export KUBECONFIG='/etc/rancher/k3s/k3s.yaml'" >> $SERVER_NODE_HOME/.bashrc
sudo apt update && sudo apt install -y curl
curl -sfL https://get.k3s.io | sh -