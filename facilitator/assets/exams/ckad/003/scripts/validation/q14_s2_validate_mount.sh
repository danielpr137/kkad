#!/bin/bash
# Q14 S2 Validation: Check volume mount

VOLUME_MOUNT=$(kubectl get pod secret-handler -n moon -o jsonpath='{.spec.containers[0].volumeMounts}')

if echo "$VOLUME_MOUNT" | grep -q "/tmp/secret-id"; then
  echo "✅ Secret mounted as volume correctly"
  exit 0
else
  echo "❌ Secret volume mount not configured"
  exit 1
fi
