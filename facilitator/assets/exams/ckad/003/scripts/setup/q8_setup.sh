#!/bin/bash
# Q8 Setup: Create deployment with history

kubectl create namespace neptune --dry-run=client -o yaml | kubectl apply -f -

kubectl create deployment neptune-deployment --image=nginx:1.16.1 --replicas=2 -n neptune
sleep 2
kubectl set image deployment/neptune-deployment nginx=nginx:1.17.0 -n neptune --record
sleep 2
kubectl set image deployment/neptune-deployment nginx=nginx:1.18.0 -n neptune --record

echo "Q8 setup complete"
