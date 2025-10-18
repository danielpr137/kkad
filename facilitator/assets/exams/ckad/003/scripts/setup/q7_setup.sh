#!/bin/bash
# Q7 Setup: Create saturn namespace and pod

kubectl create namespace saturn --dry-run=client -o yaml | kubectl apply -f -
kubectl create namespace neptune --dry-run=client -o yaml | kubectl apply -f -

cat <<PODEOF | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: my-happy-shop
  namespace: saturn
spec:
  containers:
  - name: webserver
    image: nginx:1.17.3-alpine
PODEOF

echo "Q7 setup complete"
