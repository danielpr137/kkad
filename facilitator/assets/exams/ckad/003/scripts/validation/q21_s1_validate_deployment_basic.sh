#!/bin/bash
# Q21 S1 Validation: Check deployment basic config

if ! kubectl get deployment neptune-10ab -n neptune &> /dev/null; then
  echo "❌ Deployment 'neptune-10ab' not found"
  exit 1
fi

REPLICAS=$(kubectl get deployment neptune-10ab -n neptune -o jsonpath='{.spec.replicas}')
SA=$(kubectl get deployment neptune-10ab -n neptune -o jsonpath='{.spec.template.spec.serviceAccountName}')

if [[ "$REPLICAS" == "3" ]] && [[ "$SA" == "neptune-sa-v2" ]]; then
  echo "✅ Deployment basic configuration correct"
  exit 0
else
  echo "❌ Deployment configuration incorrect"
  exit 1
fi
