#!/bin/bash
# Q12 S1 Validation: Check PV exists

if ! kubectl get pv earth-project-earthflower-pv &> /dev/null; then
  echo "❌ PersistentVolume not found"
  exit 1
fi

CAPACITY=$(kubectl get pv earth-project-earthflower-pv -o jsonpath='{.spec.capacity.storage}')
ACCESS_MODE=$(kubectl get pv earth-project-earthflower-pv -o jsonpath='{.spec.accessModes[0]}')

if [[ "$CAPACITY" == "2Gi" ]] && [[ "$ACCESS_MODE" == "ReadWriteOnce" ]]; then
  echo "✅ PersistentVolume configured correctly"
  exit 0
else
  echo "❌ PersistentVolume configuration incorrect"
  exit 1
fi
