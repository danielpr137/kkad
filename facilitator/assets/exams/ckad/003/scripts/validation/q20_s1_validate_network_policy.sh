#!/bin/bash
# Q20 S1 Validation: Check NetworkPolicy exists

if ! kubectl get networkpolicy np1 -n venus &> /dev/null; then
  echo "❌ NetworkPolicy 'np1' not found"
  exit 1
fi

POD_SELECTOR=$(kubectl get networkpolicy np1 -n venus -o jsonpath='{.spec.podSelector}')

if echo "$POD_SELECTOR" | grep -q "frontend"; then
  echo "✅ NetworkPolicy configured correctly"
  exit 0
else
  echo "❌ NetworkPolicy configuration incorrect"
  exit 1
fi
