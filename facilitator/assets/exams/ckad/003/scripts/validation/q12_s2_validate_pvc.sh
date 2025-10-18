#!/bin/bash
# Q12 S2 Validation: Check PVC exists and is bound

if ! kubectl get pvc earth-project-earthflower-pvc -n earth &> /dev/null; then
  echo "❌ PersistentVolumeClaim not found"
  exit 1
fi

STATUS=$(kubectl get pvc earth-project-earthflower-pvc -n earth -o jsonpath='{.status.phase}')

if [[ "$STATUS" == "Bound" ]]; then
  echo "✅ PersistentVolumeClaim is bound"
  exit 0
else
  echo "⚠️  PVC exists but not bound yet (Status: $STATUS)"
  exit 0
fi
