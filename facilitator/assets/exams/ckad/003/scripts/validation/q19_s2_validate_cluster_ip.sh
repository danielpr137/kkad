#!/bin/bash
# Q19 S2 Validation: Check cluster IP file

if [ -f /tmp/exam/19/cluster-ip ]; then
  echo "✅ Cluster IP file exists"
  exit 0
else
  echo "❌ Cluster IP file not found"
  exit 1
fi
