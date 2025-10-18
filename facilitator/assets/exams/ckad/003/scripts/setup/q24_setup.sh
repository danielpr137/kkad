#!/bin/bash
# Q24 Setup: Create sun namespace and service account

kubectl create namespace sun --dry-run=client -o yaml | kubectl apply -f -
kubectl create serviceaccount sa-sun-deploy -n sun

mkdir -p /tmp/exam/24

# Create verification script
cat > /tmp/exam/24/sunny_status_command.sh <<'VERIFYEOF'
#!/bin/bash
kubectl get deployment sunny -n sun -o wide
VERIFYEOF

chmod +x /tmp/exam/24/sunny_status_command.sh

echo "Q24 setup complete"
