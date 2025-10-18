#!/bin/bash
# Q13 Setup: Create moon namespace and storage class

kubectl create namespace moon --dry-run=client -o yaml | kubectl apply -f -

cat <<SCEOF | kubectl apply -f -
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: moon-retain
provisioner: kubernetes.io/no-provisioner
reclaimPolicy: Retain
volumeBindingMode: WaitForFirstConsumer
SCEOF

echo "Q13 setup complete"
