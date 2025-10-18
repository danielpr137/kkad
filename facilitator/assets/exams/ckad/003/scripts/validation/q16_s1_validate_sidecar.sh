#!/bin/bash
# Q16 S1 Validation: Check sidecar container exists

CONTAINERS=$(kubectl get deployment check-ip -n mercury -o jsonpath='{.spec.template.spec.containers[*].name}')

if echo "$CONTAINERS" | grep -q "logger"; then
  echo "✅ Sidecar container configured"
  exit 0
else
  echo "❌ Sidecar container not found"
  exit 1
fi
