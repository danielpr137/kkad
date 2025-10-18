#!/bin/bash
# Q4 S1 Validation: Check that internal-issue-report-apiv1 is uninstalled

if helm list -n mercury | grep -q "internal-issue-report-apiv1"; then
  echo "❌ Helm release 'internal-issue-report-apiv1' still exists"
  exit 1
else
  echo "✅ Helm release 'internal-issue-report-apiv1' successfully uninstalled"
  exit 0
fi
