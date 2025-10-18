#!/bin/bash
# Q7 S2 Validation: Check new pod exists in neptune

if ! kubectl get pod my-happy-shop -n neptune &> /dev/null; then
  echo "❌ Pod not found in neptune namespace"
  exit 1
fi

IMAGE=$(kubectl get pod my-happy-shop -n neptune -o jsonpath='{.spec.containers[0].image}')
if [[ "$IMAGE" == "nginx:1.17.3-alpine" ]]; then
  echo "✅ Pod exists in neptune namespace with correct configuration"
  exit 0
else
  echo "❌ Pod configuration is incorrect"
  exit 1
fi
