#!/bin/bash
# Q21 S2 Validation: Check resource limits and requests

MEM_REQUEST=$(kubectl get deployment neptune-10ab -n neptune -o jsonpath='{.spec.template.spec.containers[0].resources.requests.memory}')
MEM_LIMIT=$(kubectl get deployment neptune-10ab -n neptune -o jsonpath='{.spec.template.spec.containers[0].resources.limits.memory}')

if [[ "$MEM_REQUEST" == "20Mi" ]] && [[ "$MEM_LIMIT" == "50Mi" ]]; then
  echo "✅ Resource limits and requests configured correctly"
  exit 0
else
  echo "❌ Resource configuration incorrect"
  exit 1
fi
