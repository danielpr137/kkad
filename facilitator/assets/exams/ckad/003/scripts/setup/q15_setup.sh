#!/bin/bash
# Q15 Setup: Create configmap in moon namespace

kubectl create namespace moon --dry-run=client -o yaml | kubectl apply -f -

kubectl create configmap configmap-web-moon-html \
  --from-literal=index.html="<html><body><h1>Welcome to Moon!</h1></body></html>" \
  -n moon

echo "Q15 setup complete"
