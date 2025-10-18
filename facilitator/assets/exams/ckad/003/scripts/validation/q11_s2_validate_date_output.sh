#!/bin/bash
# Q11 S2 Validation: Check date output file

if [ -f /tmp/exam/11/date-output ]; then
  echo "✅ Date output file exists"
  exit 0
else
  echo "❌ Date output file not found"
  exit 1
fi
