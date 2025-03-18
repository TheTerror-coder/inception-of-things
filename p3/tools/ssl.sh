#!/bin/bash -e

make-argocd-ssl-certificates() {

	mkdir -p ssl/ && \
	openssl genrsa -out ssl/ca.key 2048 && \
	openssl req -x509 -new -nodes -key ssl/ca.key -sha256 -days 365 -out ssl/ca.crt -config tools/argocd-ssl.conf -extensions v3_ca -subj "/CN=argocd CA" && \
	openssl genrsa -out ssl/argocd.key 2048 && \
	openssl req -new -key ssl/argocd.key -out ssl/argocd.csr -config tools/argocd-ssl.conf -extensions v3_req && \
	openssl x509 -req -in ssl/argocd.csr -CA ssl/ca.crt -CAkey ssl/ca.key -CAcreateserial -out ssl/argocd.crt -days 365 -sha256 -extfile tools/argocd-ssl.conf -extensions v3_req
}
