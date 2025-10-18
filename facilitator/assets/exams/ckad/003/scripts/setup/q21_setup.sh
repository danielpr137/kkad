#!/bin/bash
# Q21 Setup: Create neptune namespace and service account

kubectl create namespace neptune --dry-run=client -o yaml | kubectl apply -f -
kubectl create serviceaccount neptune-sa-v2 -n neptune

echo "Q21 setup complete"
