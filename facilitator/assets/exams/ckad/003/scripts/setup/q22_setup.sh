#!/bin/bash
# Q22 Setup: Create sun namespace with pods

kubectl create namespace sun --dry-run=client -o yaml | kubectl apply -f -

# Create various pods with different labels
for i in {1..5}; do
  kubectl run pod-worker-$i --image=nginx:1.17.3-alpine --labels="type=worker" -n sun
done

for i in {1..3}; do
  kubectl run pod-runner-$i --image=nginx:1.17.3-alpine --labels="type=runner" -n sun
done

for i in {1..2}; do
  kubectl run pod-test-$i --image=nginx:1.17.3-alpine --labels="type=test" -n sun
done

mkdir -p /tmp/exam/22

echo "Q22 setup complete"
