#!/bin/bash
# Q25 S1 Validation: Check service is fixed

ENDPOINTS=$(kubectl get endpoints earth-3cc-web -n earth -o jsonpath='{.subsets[*].addresses}')

if [[ -n "$ENDPOINTS" ]]; then
  echo "✅ Service is fixed and has endpoints"
  exit 0
else
  echo "❌ Service still has no endpoints"
  exit 1
fi
