#!/bin/bash
# Q13 S1 Validation: Check PVC exists

if ! kubectl get pvc moon-pvc-126 -n moon &> /dev/null; then
  echo "❌ PersistentVolumeClaim 'moon-pvc-126' not found"
  exit 1
fi

STORAGE_REQUEST=$(kubectl get pvc moon-pvc-126 -n moon -o jsonpath='{.spec.resources.requests.storage}')
STORAGE_CLASS=$(kubectl get pvc moon-pvc-126 -n moon -o jsonpath='{.spec.storageClassName}')

if [[ "$STORAGE_REQUEST" == "3Gi" ]] && [[ "$STORAGE_CLASS" == "moon-retain" ]]; then
  echo "✅ PVC configured correctly"
  exit 0
else
  echo "❌ PVC configuration incorrect"
  exit 1
fi
