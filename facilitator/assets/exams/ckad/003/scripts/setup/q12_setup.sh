#!/bin/bash
# Q12 Setup: Create earth namespace

kubectl create namespace earth --dry-run=client -o yaml | kubectl apply -f -

# Create directory for hostpath
mkdir -p /tmp/exam-pv

echo "Q12 setup complete"
