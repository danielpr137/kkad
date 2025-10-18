#!/bin/bash
# Q9 S2 Validation: Check security context

USER_ID=$(kubectl get deployment project-plt-6cc-api -n pluto -o jsonpath='{.spec.template.spec.containers[0].securityContext.runAsUser}')
GROUP_ID=$(kubectl get deployment project-plt-6cc-api -n pluto -o jsonpath='{.spec.template.spec.containers[0].securityContext.runAsGroup}')
MEM_LIMIT=$(kubectl get deployment project-plt-6cc-api -n pluto -o jsonpath='{.spec.template.spec.containers[0].resources.limits.memory}')
MEM_REQUEST=$(kubectl get deployment project-plt-6cc-api -n pluto -o jsonpath='{.spec.template.spec.containers[0].resources.requests.memory}')

if [[ "$USER_ID" == "10000" ]] && [[ "$GROUP_ID" == "20000" ]] && [[ "$MEM_LIMIT" == "20Mi" ]] && [[ "$MEM_REQUEST" == "20Mi" ]]; then
  echo "✅ Security context and resources configured correctly"
  exit 0
else
  echo "❌ Security context or resources incorrect"
  exit 1
fi
