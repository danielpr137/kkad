#!/bin/bash
# Q10 Setup: Create deployment in pluto

kubectl create namespace pluto --dry-run=client -o yaml | kubectl apply -f -

kubectl create deployment project-earthflower --image=nginx:1.17.3-alpine --replicas=2 -n pluto

mkdir -p /tmp/exam/10

echo "Q10 setup complete"
