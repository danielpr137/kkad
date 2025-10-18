#!/bin/bash
# Q11 S1 Validation: Check container name file

if [ ! -f /tmp/exam/11/container-name ]; then
  echo "❌ Container name file not found"
  exit 1
fi

CONTAINER_NAME=$(cat /tmp/exam/11/container-name)

if [[ "$CONTAINER_NAME" == "holy-container" ]]; then
  echo "✅ Container name file correct"
  exit 0
else
  echo "❌ Container name incorrect"
  exit 1
fi
