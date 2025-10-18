#!/bin/bash
# Q9 S1 Validation: Check deployment exists with basic config

if ! kubectl get deployment project-plt-6cc-api -n pluto &> /dev/null; then
  echo "❌ Deployment 'project-plt-6cc-api' not found"
  exit 1
fi

IMAGE=$(kubectl get deployment project-plt-6cc-api -n pluto -o jsonpath='{.spec.template.spec.containers[0].image}')
REPLICAS=$(kubectl get deployment project-plt-6cc-api -n pluto -o jsonpath='{.spec.replicas}')

if [[ "$IMAGE" == "nginx:1.17.3-alpine" ]] && [[ "$REPLICAS" == "1" ]]; then
  echo "✅ Deployment exists with correct basic configuration"
  exit 0
else
  echo "❌ Deployment configuration incorrect"
  exit 1
fi
