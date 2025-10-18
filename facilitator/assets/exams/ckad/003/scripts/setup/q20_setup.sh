#!/bin/bash
# Q20 Setup: Create venus namespace and deployments

kubectl create namespace venus --dry-run=client -o yaml | kubectl apply -f -

kubectl create deployment api --image=nginx:1.17.3-alpine --replicas=1 -n venus
kubectl label deployment api component=api -n venus

kubectl create deployment frontend --image=nginx:1.17.3-alpine --replicas=1 -n venus
kubectl label deployment frontend component=frontend -n venus

echo "Q20 setup complete"
