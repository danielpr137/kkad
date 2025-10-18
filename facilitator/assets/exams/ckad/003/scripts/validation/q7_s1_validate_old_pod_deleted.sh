#!/bin/bash
# Q7 S1 Validation: Check old pod is deleted from saturn

if kubectl get pod my-happy-shop -n saturn &> /dev/null; then
  echo "❌ Pod still exists in saturn namespace"
  exit 1
else
  echo "✅ Pod removed from saturn namespace"
  exit 0
fi
