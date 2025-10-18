#!/bin/bash
# Q22 S1 Validation: Check protected label is added to correct pods

PROTECTED_COUNT=$(kubectl get pods -n sun -l protected=true --no-headers | wc -l)

if [[ "$PROTECTED_COUNT" -ge "8" ]]; then
  echo "✅ Protected label added to correct pods"
  exit 0
else
  echo "❌ Protected label not added to all required pods"
  exit 1
fi
