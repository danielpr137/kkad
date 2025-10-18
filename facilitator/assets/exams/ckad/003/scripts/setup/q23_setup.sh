#!/bin/bash
# Q23 Setup: Create deployment in pluto

kubectl create namespace pluto --dry-run=client -o yaml | kubectl apply -f -

cat <<DEPEOF | kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: project-23-api
  namespace: pluto
spec:
  replicas: 2
  selector:
    matchLabels:
      app: project-23-api
  template:
    metadata:
      labels:
        app: project-23-api
    spec:
      containers:
      - name: api
        image: nginx:1.17.3-alpine
        ports:
        - containerPort: 80
DEPEOF

mkdir -p /tmp/exam/23

# Save current deployment to file
kubectl get deployment project-23-api -n pluto -o yaml > /tmp/exam/23/project-23-api.yaml

echo "Q23 setup complete"
