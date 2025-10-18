#!/bin/bash
# Q24 S1 Validation: Check deployment with service account

if ! kubectl get deployment sunny -n sun &> /dev/null; then
  echo "❌ Deployment 'sunny' not found"
  exit 1
fi

REPLICAS=$(kubectl get deployment sunny -n sun -o jsonpath='{.spec.replicas}')
SA=$(kubectl get deployment sunny -n sun -o jsonpath='{.spec.template.spec.serviceAccountName}')

if [[ "$REPLICAS" == "4" ]] && [[ "$SA" == "sa-sun-deploy" ]]; then
  echo "✅ Deployment configured correctly with ServiceAccount"
  exit 0
else
  echo "❌ Deployment configuration incorrect"
  exit 1
fi
