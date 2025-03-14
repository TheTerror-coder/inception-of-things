#!/bin/sh -e

install-argocd-cli() {
	VERSION=$(curl -L -s https://raw.githubusercontent.com/argoproj/argo-cd/stable/VERSION)
	curl -sSL -o argocd-linux-amd64 https://github.com/argoproj/argo-cd/releases/download/v$VERSION/argocd-linux-amd64
	# sudo install -m 555 argocd-linux-amd64 /usr/local/bin/argocd
	install -m 555 argocd-linux-amd64 /usr/local/bin/argocd
	rm argocd-linux-amd64
}

curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
# sudo snap install kubectl --classic
snap install kubectl --classic
# sudo snap install helm --classic
snap install helm --classic

install-argocd-cli
