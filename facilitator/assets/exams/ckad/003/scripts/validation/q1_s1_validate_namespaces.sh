#!/bin/bash
# Q1 Validation: Check if namespaces file exists and contains namespaces

if [ ! -f /tmp/exam/1/namespaces ]; then
  echo "❌ File /tmp/exam/1/namespaces not found"
  exit 1
fi

# Check if file contains at least some common namespaces
if grep -E "(default|kube-system|kube-public|kube-node-lease)" /tmp/exam/1/namespaces > /dev/null; then
  echo "✅ Namespaces list file exists with expected content"
  exit 0
else
  echo "❌ Namespaces file doesn't contain expected namespaces"
  exit 1
fi
