#!/bin/bash

set -e

echo "Checking if NGINX Ingress Controller is already installed..."

if kubectl get namespace ingress-nginx >/dev/null 2>&1; then
    echo "NGINX Ingress Controller is already installed. Skipping installation."

    kubectl get pods -n ingress-nginx
    kubectl get svc -n ingress-nginx

    exit 0
fi

echo "Installing NGINX Ingress Controller..."

kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/cloud/deploy.yaml

echo "Waiting for Ingress Controller pods to become ready..."

kubectl wait \
  --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=600s

echo "NGINX Ingress Controller installed successfully."

kubectl get pods -n ingress-nginx
kubectl get svc -n ingress-nginx
kubectl get ingressclass