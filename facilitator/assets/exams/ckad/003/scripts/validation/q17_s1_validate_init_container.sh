#!/bin/bash
# Q17 S1 Validation: Check init container

if ! kubectl get pod holy-api-v2 -n default &> /dev/null; then
  echo "❌ Pod 'holy-api-v2' not found"
  exit 1
fi

INIT_CONTAINERS=$(kubectl get pod holy-api-v2 -n default -o jsonpath='{.spec.initContainers[*].name}')

if echo "$INIT_CONTAINERS" | grep -q "init-container"; then
  echo "✅ Init container configured correctly"
  exit 0
else
  echo "❌ Init container not found"
  exit 1
fi
