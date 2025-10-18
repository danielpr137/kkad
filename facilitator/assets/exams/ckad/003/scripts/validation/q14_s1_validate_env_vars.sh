#!/bin/bash
# Q14 S1 Validation: Check environment variables

if ! kubectl get pod secret-handler -n moon &> /dev/null; then
  echo "❌ Pod 'secret-handler' not found"
  exit 1
fi

# Check if env vars are configured (can't easily verify values without exec)
ENV_VARS=$(kubectl get pod secret-handler -n moon -o jsonpath='{.spec.containers[0].env}')

if echo "$ENV_VARS" | grep -q "SECRET_USER" && echo "$ENV_VARS" | grep -q "SECRET_PASS"; then
  echo "✅ Environment variables configured"
  exit 0
else
  echo "❌ Environment variables not configured correctly"
  exit 1
fi
