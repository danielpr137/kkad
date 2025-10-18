#!/bin/bash
# Q14 Setup: Create secret in moon namespace

kubectl create namespace moon --dry-run=client -o yaml | kubectl apply -f -

kubectl create secret generic secret-handler \
  --from-literal=user=admin \
  --from-literal=pass=secretpass123 \
  --from-literal=id=ID-12345 \
  -n moon

echo "Q14 setup complete"
