#!/bin/bash
# Q10 S1 Validation: Check service exists with correct config

if ! kubectl get svc project-plt-6cc-svc -n pluto &> /dev/null; then
  echo "❌ Service 'project-plt-6cc-svc' not found"
  exit 1
fi

PORT=$(kubectl get svc project-plt-6cc-svc -n pluto -o jsonpath='{.spec.ports[0].port}')
TARGET_PORT=$(kubectl get svc project-plt-6cc-svc -n pluto -o jsonpath='{.spec.ports[0].targetPort}')

if [[ "$PORT" == "3333" ]] && [[ "$TARGET_PORT" == "80" ]]; then
  echo "✅ Service configured correctly"
  exit 0
else
  echo "❌ Service configuration incorrect"
  exit 1
fi
