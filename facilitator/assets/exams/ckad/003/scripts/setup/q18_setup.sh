#!/bin/bash
# Q18 Setup: Create mars namespace

kubectl create namespace mars --dry-run=client -o yaml | kubectl apply -f -

echo "Q18 setup complete"
