#!/bin/bash
# Q10 S2 Validation: Check logs file exists

if [ -f /tmp/exam/10/logs ]; then
  echo "✅ Logs file exists"
  exit 0
else
  echo "❌ Logs file not found"
  exit 1
fi
