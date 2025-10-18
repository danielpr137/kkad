#!/bin/bash
# Q8 S2 Validation: Check deployment has correct image and replicas

IMAGE=$(kubectl get deployment neptune-deployment -n neptune -o jsonpath='{.spec.template.spec.containers[0].image}')
REPLICAS=$(kubectl get deployment neptune-deployment -n neptune -o jsonpath='{.spec.replicas}')

if [[ "$IMAGE" == "httpd:2.4.41-alpine" ]] && [[ "$REPLICAS" == "4" ]]; then
  echo "✅ Deployment has correct image and replicas"
  exit 0
else
  echo "❌ Deployment configuration incorrect. Image: $IMAGE, Replicas: $REPLICAS"
  exit 1
fi
