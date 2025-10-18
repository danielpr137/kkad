#!/bin/bash
# Q16 Setup: Create deployment in mercury

kubectl create namespace mercury --dry-run=client -o yaml | kubectl apply -f -

cat <<DEPEOF | kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: check-ip
  namespace: mercury
spec:
  replicas: 1
  selector:
    matchLabels:
      app: check-ip
  template:
    metadata:
      labels:
        app: check-ip
    spec:
      containers:
      - name: main
        image: busybox:1.31.0
        command:
        - sh
        - -c
        - "while true; do date >> /var/log/check-ip.log; sleep 5; done"
DEPEOF

mkdir -p /tmp/exam/16

echo "Q16 setup complete"
