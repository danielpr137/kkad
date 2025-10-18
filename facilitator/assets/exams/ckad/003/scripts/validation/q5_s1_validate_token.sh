#!/bin/bash
# Q5 Validation: Check if token file exists and contains valid token

if [ ! -f /tmp/exam/5/token ]; then
  echo "❌ Token file not found at /tmp/exam/5/token"
  exit 1
fi

TOKEN=$(cat /tmp/exam/5/token)

if [[ -n "$TOKEN" ]] && [[ ${#TOKEN} -gt 20 ]]; then
  echo "✅ Token file exists with valid token"
  exit 0
else
  echo "❌ Token file exists but token appears invalid"
  exit 1
fi
