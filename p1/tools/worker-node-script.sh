#!/bin/sh -e

echo SERVER_NODE_HOME: $SERVER_NODE_HOME
export INSTALL_K3S_EXEC="agent --server $K3S_URL --node-ip $WORKER_NODE_ETH1_IP"
sudo apt update && sudo apt install -y curl
curl -sfL https://get.k3s.io | sh -s -