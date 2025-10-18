#!/bin/bash
# Q25 S2 Validation: Check reason file exists

if [ -f /tmp/exam/25/ticket-654.txt ]; then
  echo "✅ Reason file exists"
  exit 0
else
  echo "❌ Reason file not found"
  exit 1
fi
