#!/bin/bash
# Q5 Setup: Create ServiceAccount with secret

kubectl create namespace neptune --dry-run=client -o yaml | kubectl apply -f -
kubectl create serviceaccount neptune-sa-v2 -n neptune

# Wait for token secret to be created
sleep 2

mkdir -p /tmp/exam/5
