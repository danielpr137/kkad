#!/bin/bash
# Q3 Setup: Create neptune namespace and job template

kubectl create namespace neptune --dry-run=client -o yaml | kubectl apply -f -

mkdir -p /tmp/exam/3

cat > /tmp/exam/3/job.yaml <<'JOBEOF'
apiVersion: batch/v1
kind: Job
metadata:
  name: neb-new-job
  namespace: neptune
spec:
  completions: 3
  parallelism: 2
  template:
    metadata:
      labels:
        job-name: neb-new-job
    spec:
      containers:
      - name: container
        image: busybox:1.31.0
        command:
        - sh
        - -c
        - "echo change this"
      restartPolicy: Never
JOBEOF

echo "Q3 setup complete"
