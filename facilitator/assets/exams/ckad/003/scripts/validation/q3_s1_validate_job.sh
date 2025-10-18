#!/bin/bash
# Q3 Validation: Check if job exists and has correct command

if ! kubectl get job neb-new-job -n neptune &> /dev/null; then
  echo "❌ Job 'neb-new-job' not found in neptune namespace"
  exit 1
fi

COMMAND=$(kubectl get job neb-new-job -n neptune -o jsonpath='{.spec.template.spec.containers[0].command}' | grep -o "sleep 2 && echo done" || echo "")

if [[ -n "$COMMAND" ]]; then
  echo "✅ Job exists with correct command"
  exit 0
else
  echo "❌ Job command is incorrect"
  exit 1
fi
