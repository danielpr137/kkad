#!/bin/bash
# Q9 Setup: Create pluto namespace

kubectl create namespace pluto --dry-run=client -o yaml | kubectl apply -f -

echo "Q9 setup complete"
