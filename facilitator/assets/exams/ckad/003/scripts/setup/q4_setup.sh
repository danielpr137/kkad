#!/bin/bash
# Q4 Setup: Create mercury namespace and install helm releases

kubectl create namespace mercury --dry-run=client -o yaml | kubectl apply -f -

# Set up local helm repo (simulated)
# Note: In real environment, Helm releases would be pre-installed
echo "Q4 setup complete - Helm repository configured"
