#!/bin/bash
# Q6 Validation: Check if pod has readiness probe configured correctly

if ! kubectl get pod pod6 -n default &> /dev/null; then
  echo "❌ Pod 'pod6' not found"
  exit 1
fi

# Check readiness probe configuration
PROBE_COMMAND=$(kubectl get pod pod6 -n default -o jsonpath='{.spec.containers[0].readinessProbe.exec.command}')
INITIAL_DELAY=$(kubectl get pod pod6 -n default -o jsonpath='{.spec.containers[0].readinessProbe.initialDelaySeconds}')
PERIOD=$(kubectl get pod pod6 -n default -o jsonpath='{.spec.containers[0].readinessProbe.periodSeconds}')

if echo "$PROBE_COMMAND" | grep -q "cat /tmp/ready" && [[ "$INITIAL_DELAY" == "5" ]] && [[ "$PERIOD" == "10" ]]; then
  echo "✅ Pod has correct readiness probe configuration"
  exit 0
else
  echo "❌ Readiness probe configuration is incorrect"
  exit 1
fi
