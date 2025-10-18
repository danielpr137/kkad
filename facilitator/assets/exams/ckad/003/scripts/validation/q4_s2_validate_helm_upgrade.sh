#!/bin/bash
# Q4 S2 Validation: Check that internal-issue-report-apiv2 is upgraded

CHART_VERSION=$(helm list -n mercury -o json | jq -r '.[] | select(.name=="internal-issue-report-apiv2") | .chart' | grep -o "2.0.0" || echo "")

if [[ -n "$CHART_VERSION" ]]; then
  echo "✅ Helm release 'internal-issue-report-apiv2' upgraded to version 2.0.0"
  exit 0
else
  echo "❌ Helm release not upgraded correctly"
  exit 1
fi
