#!/bin/bash
# Q18 S1 Validation: Check deployment exists

if ! kubectl get deployment manager-mars-api -n mars &> /dev/null; then
  echo "❌ Deployment 'manager-mars-api' not found"
  exit 1
fi

REPLICAS=$(kubectl get deployment manager-mars-api -n mars -o jsonpath='{.spec.replicas}')

if [[ "$REPLICAS" == "3" ]]; then
  echo "✅ Deployment configured correctly"
  exit 0
else
  echo "❌ Deployment replicas incorrect"
  exit 1
fi
