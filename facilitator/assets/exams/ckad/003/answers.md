# CKAD Killer Shell Simulator - Complete Answers

## Question 1 | Namespaces

**Task:** Get list of all Namespaces and save to `/tmp/exam/1/namespaces`

**Solution:**
```bash
kubectl get namespaces > /tmp/exam/1/namespaces
# or
kubectl get ns > /tmp/exam/1/namespaces
```

**Explanation:**
This is a straightforward kubectl command to list all namespaces. The output redirection (`>`) saves the list to the specified file.

---

## Question 2 | Pods

**Task:** Create a Pod named `pod1` with image `httpd:2.4.41-alpine` and container name `pod1-container`

**Solution:**
```bash
kubectl run pod1 --image=httpd:2.4.41-alpine --dry-run=client -o yaml > pod1.yaml
```

Edit the YAML to set container name:
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: pod1
  namespace: default
spec:
  containers:
  - name: pod1-container
    image: httpd:2.4.41-alpine
```

Apply:
```bash
kubectl apply -f pod1.yaml
```

**Alternative - Imperative:**
```bash
kubectl run pod1 --image=httpd:2.4.41-alpine $do > pod1.yaml
# Edit to change container name, then apply
kubectl apply -f pod1.yaml
```

---

## Question 3 | Job

**Task:** Create Job from template at `/tmp/exam/3/job.yaml` that runs `sleep 2 && echo done`

**Solution:**
```bash
# Edit the job template
vi /tmp/exam/3/job.yaml
```

Change the command section:
```yaml
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
        - "sleep 2 && echo done"
      restartPolicy: Never
```

Apply:
```bash
kubectl apply -f /tmp/exam/3/job.yaml
```

Verify:
```bash
kubectl get jobs -n neptune
kubectl get pods -n neptune
```

---

## Question 4 | Helm Management

**Task:** Uninstall `internal-issue-report-apiv1` and upgrade `internal-issue-report-apiv2` to version 2.0.0

**Solution:**
```bash
# Update helm repos first
helm repo update

# Uninstall the first release
helm uninstall internal-issue-report-apiv1 -n mercury

# Upgrade the second release
helm upgrade internal-issue-report-apiv2 killershell/internal-issue-report --version 2.0.0 -n mercury

# Verify
helm list -n mercury
```

**Explanation:**
Helm operations are straightforward - `uninstall` removes a release, and `upgrade` updates an existing release to a new version. Always specify the namespace with `-n`.

---

## Question 5 | ServiceAccount, Secret

**Task:** Extract token from ServiceAccount `neptune-sa-v2` and save to `/tmp/exam/5/token`

**Solution:**
```bash
# Find the secret associated with the ServiceAccount
SECRET_NAME=$(kubectl get sa neptune-sa-v2 -n neptune -o jsonpath='{.secrets[0].name}')

# Extract the token
kubectl get secret $SECRET_NAME -n neptune -o jsonpath='{.data.token}' | base64 -d > /tmp/exam/5/token
```

**Alternative approach (K8s 1.24+):**
```bash
# In newer Kubernetes versions, tokens might not be automatically created
# Create a token manually
kubectl create token neptune-sa-v2 -n neptune > /tmp/exam/5/token
```

**Explanation:**
ServiceAccounts have associated secrets containing tokens. We extract the secret name, then decode the base64-encoded token and save it to a file.

---

## Question 6 | ReadinessProbe

**Task:** Create Pod with readiness probe that checks `/tmp/ready`

**Solution:**
```bash
kubectl run pod6 --image=busybox:1.31.0 --dry-run=client -o yaml -- sh -c "touch /tmp/ready && sleep 1d" > pod6.yaml
```

Edit to add readiness probe:
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: pod6
  namespace: default
spec:
  containers:
  - name: pod6
    image: busybox:1.31.0
    command:
    - sh
    - -c
    - "touch /tmp/ready && sleep 1d"
    readinessProbe:
      exec:
        command:
        - cat
        - /tmp/ready
      initialDelaySeconds: 5
      periodSeconds: 10
```

Apply:
```bash
kubectl apply -f pod6.yaml
```

**Explanation:**
Readiness probes determine when a container is ready to accept traffic. The `exec` probe runs a command - if it exits with status 0, the container is ready.

---

## Question 7 | Pods, Namespaces

**Task:** Move Pod `my-happy-shop` from `saturn` to `neptune` namespace

**Solution:**
```bash
# Get the pod yaml
kubectl get pod my-happy-shop -n saturn -o yaml > my-happy-shop.yaml

# Edit the yaml to change namespace
sed -i 's/namespace: saturn/namespace: neptune/g' my-happy-shop.yaml

# Delete old pod
kubectl delete pod my-happy-shop -n saturn

# Create in new namespace
kubectl apply -f my-happy-shop.yaml
```

**Alternative:**
```bash
kubectl get pod my-happy-shop -n saturn -o yaml | \
  sed 's/namespace: saturn/namespace: neptune/' | \
  kubectl apply -f -
  
kubectl delete pod my-happy-shop -n saturn
```

**Explanation:**
Pods cannot be moved between namespaces. We must recreate them. Export the YAML, modify the namespace, delete the original, and create in the new namespace.

---

## Question 8 | Deployments, Rollouts

**Task:** Rollback deployment to revision 1, update image, and scale to 4 replicas

**Solution:**
```bash
# Check rollout history
kubectl rollout history deployment neptune-deployment -n neptune

# Rollback to revision 1
kubectl rollout undo deployment neptune-deployment -n neptune --to-revision=1

# Update image
kubectl set image deployment neptune-deployment nginx=httpd:2.4.41-alpine -n neptune

# Scale deployment
kubectl scale deployment neptune-deployment --replicas=4 -n neptune

# Verify
kubectl get deployment neptune-deployment -n neptune
```

**Explanation:**
Kubernetes tracks deployment revisions. `rollout undo` reverts to a previous revision, `set image` updates the container image, and `scale` changes replica count.

---

## Question 9 | Deployment with Security Context

**Task:** Create deployment with security context and resource limits

**Solution:**
```bash
kubectl create deployment project-plt-6cc-api --image=nginx:1.17.3-alpine --replicas=1 -n pluto --dry-run=client -o yaml > dep.yaml
```

Edit the YAML:
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: project-plt-6cc-api
  namespace: pluto
spec:
  replicas: 1
  selector:
    matchLabels:
      app: project-plt-6cc-api
  template:
    metadata:
      labels:
        app: project-plt-6cc-api
    spec:
      containers:
      - name: api
        image: nginx:1.17.3-alpine
        securityContext:
          runAsUser: 10000
          runAsGroup: 20000
          capabilities:
            drop:
            - ALL
        resources:
          requests:
            memory: "20Mi"
          limits:
            memory: "20Mi"
```

Apply:
```bash
kubectl apply -f dep.yaml
```

**Explanation:**
Security contexts define privilege and access control settings. Setting `runAsUser` and `runAsGroup` ensures containers run as non-root users. Dropping all capabilities minimizes attack surface.

---

## Question 10 | Services and Logs

**Task:** Create ClusterIP service and save pod logs

**Solution:**
```bash
# Create service
kubectl expose deployment project-earthflower --name=project-plt-6cc-svc --port=3333 --target-port=80 -n pluto

# Get logs from one pod
POD_NAME=$(kubectl get pods -n pluto -l app=project-earthflower -o jsonpath='{.items[0].metadata.name}')
kubectl logs $POD_NAME -n pluto > /tmp/exam/10/logs
```

**Explanation:**
`kubectl expose` creates a service for a deployment. The service port (3333) is what clients connect to, while targetPort (80) is the container port.

---

## Question 11 | Container Operations

**Task:** Get container name and execute command in container

**Solution:**
```bash
# Get container name
kubectl get pod holy-api -n default -o jsonpath='{.spec.containers[0].name}' > /tmp/exam/11/container-name

# Execute date command
kubectl exec holy-api -n default -- date > /tmp/exam/11/date-output
```

**Explanation:**
`kubectl exec` runs commands in containers. The `--` separates kubectl options from the command to execute.

---

## Question 12 | PersistentVolumes and PersistentVolumeClaims

**Task:** Create PV and PVC

**Solution:**

Create PV:
```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: earth-project-earthflower-pv
spec:
  capacity:
    storage: 2Gi
  accessModes:
  - ReadWriteOnce
  storageClassName: shared-host-path
  hostPath:
    path: /tmp/exam-pv
```

Create PVC:
```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: earth-project-earthflower-pvc
  namespace: earth
spec:
  accessModes:
  - ReadWriteOnce
  resources:
    requests:
      storage: 2Gi
  storageClassName: shared-host-path
```

Apply both:
```bash
kubectl apply -f pv.yaml
kubectl apply -f pvc.yaml
```

**Explanation:**
PVs are cluster-wide storage resources. PVCs request storage from PVs. The storageClassName and accessModes must match for binding.

---

## Question 13 | PVC with StorageClass

**Task:** Create PVC with storage class `moon-retain`

**Solution:**
```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: moon-pvc-126
  namespace: moon
spec:
  accessModes:
  - ReadWriteOnce
  storageClassName: moon-retain
  resources:
    requests:
      storage: 3Gi
```

If PVC doesn't bind, create a matching PV:
```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: moon-pv-126
spec:
  capacity:
    storage: 3Gi
  accessModes:
  - ReadWriteOnce
  storageClassName: moon-retain
  hostPath:
    path: /tmp/moon-pv
```

---

## Question 14 | Secrets as Environment Variables and Volumes

**Task:** Use secret as both env vars and volume mount

**Solution:**
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: secret-handler
  namespace: moon
spec:
  containers:
  - name: container
    image: bash:5.0.11
    command:
    - bash
    - -c
    - sleep 1d
    env:
    - name: SECRET_USER
      valueFrom:
        secretKeyRef:
          name: secret-handler
          key: user
    - name: SECRET_PASS
      valueFrom:
        secretKeyRef:
          name: secret-handler
          key: pass
    volumeMounts:
    - name: secret-volume
      mountPath: /tmp/secret-id
      subPath: id
  volumes:
  - name: secret-volume
    secret:
      secretName: secret-handler
```

---

## Question 15 | ConfigMap as Volume

**Task:** Mount ConfigMap as volume in nginx pod

**Solution:**
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: web-moon
  namespace: moon
spec:
  containers:
  - name: nginx
    image: nginx:1.17.3-alpine
    volumeMounts:
    - name: html
      mountPath: /usr/share/nginx/html
  volumes:
  - name: html
    configMap:
      name: configmap-web-moon-html
```

---

## Question 16 | Sidecar Container

**Task:** Add logging sidecar container to deployment

**Solution:**
```bash
# Get current deployment
kubectl get deployment check-ip -n mercury -o yaml > /tmp/exam/16/check-ip-deployment.yaml

# Edit to add sidecar
```

Add to containers array:
```yaml
- name: logger
  image: busybox:1.31.0
  command:
  - sh
  - -c
  - tail -f /var/log/check-ip.log
  volumeMounts:
  - name: logger-volume
    mountPath: /var/log
```

Add volume:
```yaml
volumes:
- name: logger-volume
  emptyDir: {}
```

Update main container to use the volume:
```yaml
volumeMounts:
- name: logger-volume
  mountPath: /var/log
```

Apply:
```bash
kubectl apply -f /tmp/exam/16/check-ip-deployment.yaml
```

---

## Question 17 | Init Containers

**Task:** Create pod with init container

**Solution:**
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: holy-api-v2
  namespace: default
spec:
  initContainers:
  - name: init-container
    image: busybox:1.31.0
    command:
    - sh
    - -c
    - echo Init done > /tmp/init-done.txt
    volumeMounts:
    - name: workdir
      mountPath: /tmp
  containers:
  - name: main-container
    image: nginx:1.17.3-alpine
    volumeMounts:
    - name: workdir
      mountPath: /tmp
  volumes:
  - name: workdir
    emptyDir: {}
```

---

## Question 18 | NodePort Service

**Task:** Create deployment and NodePort service

**Solution:**
```bash
# Create deployment
kubectl create deployment manager-mars-api --image=httpd:2.4-alpine --replicas=3 -n mars

# Create NodePort service
kubectl expose deployment manager-mars-api --name=manager-api-svc --port=4444 --target-port=80 --type=NodePort -n mars

# Set specific NodePort
kubectl patch service manager-api-svc -n mars -p '{"spec":{"ports":[{"port":4444,"targetPort":80,"nodePort":30080}]}}'
```

**Or create service YAML:**
```yaml
apiVersion: v1
kind: Service
metadata:
  name: manager-api-svc
  namespace: mars
spec:
  type: NodePort
  selector:
    app: manager-mars-api
  ports:
  - port: 4444
    targetPort: 80
    nodePort: 30080
```

---

## Question 19 | Service Testing

**Task:** Test service connectivity and get ClusterIP

**Solution:**
```bash
# Test service (if service exists in jupiter namespace)
kubectl run test-pod --image=busybox:1.31.0 --rm -it -n jupiter -- wget -O- manager-api-svc.mars:4444 > /tmp/exam/19/service-test

# Get ClusterIP
kubectl get svc manager-api-svc -n mars -o jsonpath='{.spec.clusterIP}' > /tmp/exam/19/cluster-ip
```

---

## Question 20 | NetworkPolicy

**Task:** Create NetworkPolicy to restrict traffic

**Solution:**
```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: np1
  namespace: venus
spec:
  podSelector:
    matchLabels:
      component: frontend
  policyTypes:
  - Ingress
  ingress:
  - from:
    - podSelector:
        matchLabels:
          component: api
    ports:
    - port: 80
      protocol: TCP
```

**Explanation:**
This NetworkPolicy applies to pods with label `component: frontend`. It allows ingress only from pods with label `component: api` on port 80. All other traffic is denied by default.

---

## Question 21 | Resource Limits and ServiceAccount

**Task:** Create deployment with resource limits and ServiceAccount

**Solution:**
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: neptune-10ab
  namespace: neptune
spec:
  replicas: 3
  selector:
    matchLabels:
      app: neptune-10ab
  template:
    metadata:
      labels:
        app: neptune-10ab
    spec:
      serviceAccountName: neptune-sa-v2
      containers:
      - name: neptune-pod-10ab
        image: httpd:2.4-alpine
        resources:
          requests:
            memory: "20Mi"
          limits:
            memory: "50Mi"
```

---

## Question 22 | Labels

**Task:** Add label to multiple pods

**Solution:**
```bash
# Add label to worker pods
kubectl label pods -n sun -l type=worker protected=true

# Add label to runner pods
kubectl label pods -n sun -l type=runner protected=true

# Save list of protected pods
kubectl get pods -n sun -l protected=true > /tmp/exam/22/protected-pods
```

**Explanation:**
Labels can be added to multiple pods using label selectors. The `-l` flag filters pods by existing labels.

---

## Question 23 | Liveness Probe (Preview)

**Task:** Add TCP liveness probe to deployment

**Solution:**
```bash
# Get current deployment
kubectl get deployment project-23-api -n pluto -o yaml > /tmp/exam/23/project-23-api.yaml
```

Add liveness probe to container spec:
```yaml
livenessProbe:
  tcpSocket:
    port: 80
  initialDelaySeconds: 10
  periodSeconds: 15
```

Save and apply:
```bash
# Save modified version
vi /tmp/exam/23/project-23-api-new.yaml  # Make changes
kubectl apply -f /tmp/exam/23/project-23-api-new.yaml
```

---

## Question 24 | Deployment with ServiceAccount (Preview)

**Task:** Create deployment with ServiceAccount

**Solution:**
```bash
kubectl create deployment sunny --image=nginx:1.17.3-alpine --replicas=4 -n sun --dry-run=client -o yaml > sunny.yaml
```

Edit to add ServiceAccount:
```yaml
spec:
  template:
    spec:
      serviceAccountName: sa-sun-deploy
```

Apply:
```bash
kubectl apply -f sunny.yaml
```

Verify:
```bash
/tmp/exam/24/sunny_status_command.sh
```

---

## Question 25 | Service Troubleshooting (Preview)

**Task:** Fix broken service and document the issue

**Solution:**
```bash
# Check service
kubectl describe svc earth-3cc-web -n earth

# Check endpoints
kubectl get endpoints earth-3cc-web -n earth

# Check pod labels
kubectl get pods -n earth --show-labels

# The issue: Service selector doesn't match pod labels
# Fix: Update service selector

kubectl edit svc earth-3cc-web -n earth
# Change selector from component: web-3cc-wrong to component: web-3cc

# Document the issue
echo "The Service selector 'component: web-3cc-wrong' did not match the Pod labels 'component: web-3cc'. Updated the Service selector to match the correct Pod labels." > /tmp/exam/25/ticket-654.txt
```

**Explanation:**
Services use selectors to identify which pods to route traffic to. If the selector doesn't match any pod labels, the service will have no endpoints and won't work. Always verify selectors match pod labels.

---

## General Tips for CKAD Exam:

1. **Use kubectl shortcuts:** `k` alias and `-n` for namespace
2. **Use --dry-run=client -o yaml** to generate YAML templates
3. **Use kubectl explain** for field documentation
4. **Practice imperative commands** for speed
5. **Master kubectl run, create, expose, and set commands**
6. **Know how to quickly edit resources** with `kubectl edit`
7. **Understand pod lifecycle, probes, and init containers**
8. **Be comfortable with multi-container patterns**
9. **Practice troubleshooting** services and network policies
10. **Time management:** Flag difficult questions and return later

---

**End of Answers Document**
