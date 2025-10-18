#!/bin/bash
# Q22 S2 Validation: Check protected pods list file

if [ -f /tmp/exam/22/protected-pods ]; then
  echo "✅ Protected pods list file exists"
  exit 0
else
  echo "❌ Protected pods list file not found"
  exit 1
fi
