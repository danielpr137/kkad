#!/bin/bash
# Q11 Setup: Create pod holy-api

cat <<PODEOF | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: holy-api
  namespace: default
spec:
  containers:
  - name: holy-container
    image: nginx:1.17.3-alpine
PODEOF

mkdir -p /tmp/exam/11

echo "Q11 setup complete"
