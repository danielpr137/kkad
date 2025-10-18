#!/bin/bash
# Q2 Validation: Check pod1 exists with correct image and container name

if ! kubectl get pod pod1 -n default &> /dev/null; then
  echo "❌ Pod 'pod1' not found in default namespace"
  exit 1
fi

IMAGE=$(kubectl get pod pod1 -n default -o jsonpath='{.spec.containers[0].image}')
CONTAINER_NAME=$(kubectl get pod pod1 -n default -o jsonpath='{.spec.containers[0].name}')

if [[ "$IMAGE" == "httpd:2.4.41-alpine" ]] && [[ "$CONTAINER_NAME" == "pod1-container" ]]; then
  echo "✅ Pod 'pod1' exists with correct image and container name"
  exit 0
else
  echo "❌ Pod configuration incorrect. Image: $IMAGE, Container: $CONTAINER_NAME"
  exit 1
fi
