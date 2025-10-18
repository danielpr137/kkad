#!/bin/bash
# Q19 S1 Validation: Check service test output file

if [ -f /tmp/exam/19/service-test ]; then
  echo "✅ Service test output file exists"
  exit 0
else
  echo "❌ Service test output file not found"
  exit 1
fi
