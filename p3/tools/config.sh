#!/bin/sh -e

curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
snap install kubectl --classic
sudo snap install helm --classic
helm upgrade --install ingress-nginx ingress-nginx \
  --repo https://kubernetes.github.io/ingress-nginx \
  --namespace ingress-nginx --create-namespace