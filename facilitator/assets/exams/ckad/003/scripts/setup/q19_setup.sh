#!/bin/bash
# Q19 Setup: Create jupiter namespace

kubectl create namespace jupiter --dry-run=client -o yaml | kubectl apply -f -

mkdir -p /tmp/exam/19

echo "Q19 setup complete"
