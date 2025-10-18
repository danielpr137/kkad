#!/bin/bash
# Q25 Setup: Create earth namespace with services and deployments

kubectl create namespace earth --dry-run=client -o yaml | kubectl apply -f -

# Create deployments with specific labels
kubectl create deployment earth-3cc-web --image=nginx:1.17.3-alpine --replicas=2 -n earth
kubectl label deployment earth-3cc-web component=web-3cc -n earth

kubectl create deployment earth-2x3-api --image=nginx:1.17.3-alpine --replicas=1 -n earth
kubectl label deployment earth-2x3-api component=api-2x3 -n earth

# Create a broken service (wrong selector)
cat <<SVCEOF | kubectl apply -f -
apiVersion: v1
kind: Service
metadata:
  name: earth-3cc-web
  namespace: earth
spec:
  selector:
    component: web-3cc-wrong
  ports:
  - port: 80
    targetPort: 80
SVCEOF

mkdir -p /tmp/exam/25

echo "Q25 setup complete"
