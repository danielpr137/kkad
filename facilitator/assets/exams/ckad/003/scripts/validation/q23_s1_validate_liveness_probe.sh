#!/bin/bash
# Q23 S1 Validation: Check liveness probe is configured

LIVENESS_PROBE=$(kubectl get deployment project-23-api -n pluto -o jsonpath='{.spec.template.spec.containers[0].livenessProbe}')

if echo "$LIVENESS_PROBE" | grep -q "tcpSocket" && echo "$LIVENESS_PROBE" | grep -q "10" && echo "$LIVENESS_PROBE" | grep -q "15"; then
  echo "✅ Liveness probe configured correctly"
  exit 0
else
  echo "❌ Liveness probe not configured correctly"
  exit 1
fi
