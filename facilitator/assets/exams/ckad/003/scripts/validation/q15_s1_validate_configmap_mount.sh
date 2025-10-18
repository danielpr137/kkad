#!/bin/bash
# Q15 S1 Validation: Check pod with configmap mount

if ! kubectl get pod web-moon -n moon &> /dev/null; then
  echo "❌ Pod 'web-moon' not found"
  exit 1
fi

VOLUME_MOUNT=$(kubectl get pod web-moon -n moon -o jsonpath='{.spec.containers[0].volumeMounts}')

if echo "$VOLUME_MOUNT" | grep -q "/usr/share/nginx/html"; then
  echo "✅ ConfigMap mounted correctly"
  exit 0
else
  echo "❌ ConfigMap volume mount not configured"
  exit 1
fi
