#!/bin/bash
# Q8 S1 Validation: Check deployment is at revision 1

CURRENT_IMAGE=$(kubectl get deployment neptune-deployment -n neptune -o jsonpath='{.spec.template.spec.containers[0].image}')

if [[ "$CURRENT_IMAGE" == *"nginx:1.16"* ]] || kubectl rollout history deployment/neptune-deployment -n neptune | grep -q "revision 1"; then
  echo "✅ Deployment rolled back to revision 1"
  exit 0
else
  echo "❌ Deployment not at correct revision"
  exit 1
fi
