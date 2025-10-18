#!/bin/bash
# Q18 S2 Validation: Check NodePort service

if ! kubectl get svc manager-api-svc -n mars &> /dev/null; then
  echo "❌ Service 'manager-api-svc' not found"
  exit 1
fi

SERVICE_TYPE=$(kubectl get svc manager-api-svc -n mars -o jsonpath='{.spec.type}')
NODE_PORT=$(kubectl get svc manager-api-svc -n mars -o jsonpath='{.spec.ports[0].nodePort}')
PORT=$(kubectl get svc manager-api-svc -n mars -o jsonpath='{.spec.ports[0].port}')

if [[ "$SERVICE_TYPE" == "NodePort" ]] && [[ "$NODE_PORT" == "30080" ]] && [[ "$PORT" == "4444" ]]; then
  echo "✅ NodePort service configured correctly"
  exit 0
else
  echo "❌ Service configuration incorrect"
  exit 1
fi
