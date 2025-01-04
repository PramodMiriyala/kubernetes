Kubernetes no longer uses the `kubectl rolling-update` command as it has been deprecated in favor of **Deployments**, which provide more flexibility and features for managing rolling updates and rollbacks.

Below are the modern alternatives for performing **rolling updates** and **rollbacks** using Deployments.

---

## **Rolling Update with Deployments**

### 1. **Update a Deployment**
Modify the Deployment manifest (e.g., `deployment.yaml`) or update the image directly using the following command:

```bash
kubectl set image deployment/<DEPLOYMENT_NAME> <CONTAINER_NAME>=<NEW_IMAGE> --record
```

- Example:
  ```bash
  kubectl set image deployment/nginx-deployment nginx=nginx:1.25 --record
  ```

- The `--record` flag keeps a record of the change in the rollout history.

### 2. **Monitor the Rollout**
Check the status of the rollout to ensure it completes successfully:
```bash
kubectl rollout status deployment/<DEPLOYMENT_NAME>
```

- Example:
  ```bash
  kubectl rollout status deployment/nginx-deployment
  ```

---

## **Rollback to a Previous Revision**

### 1. **View Rollout History**
List the revision history of the Deployment:
```bash
kubectl rollout history deployment/<DEPLOYMENT_NAME>
```

- Example:
  ```bash
  kubectl rollout history deployment/nginx-deployment
  ```

### 2. **Rollback to a Previous Revision**
Rollback the Deployment to a specific revision:
```bash
kubectl rollout undo deployment/<DEPLOYMENT_NAME> --to-revision=<REVISION_NUMBER>
```

- Example:
  ```bash
  kubectl rollout undo deployment/nginx-deployment --to-revision=2
  ```

If you omit the `--to-revision` flag, it rolls back to the previous revision:
```bash
kubectl rollout undo deployment/<DEPLOYMENT_NAME>
```

- Example:
  ```bash
  kubectl rollout undo deployment/nginx-deployment
  ```

---

## **View the Deployment Status**

Check the status of the Deployment to ensure it is updated or rolled back successfully:
```bash
kubectl get deployment <DEPLOYMENT_NAME>
```

- Example:
  ```bash
  kubectl get deployment nginx-deployment
  ```

---

## **Rollback Example**

1. Update the Deployment to a new image:
   ```bash
   kubectl set image deployment/nginx-deployment nginx=nginx:1.25 --record
   ```

2. Check the rollout status:
   ```bash
   kubectl rollout status deployment/nginx-deployment
   ```

3. View the rollout history:
   ```bash
   kubectl rollout history deployment/nginx-deployment
   ```

4. Rollback to the previous version:
   ```bash
   kubectl rollout undo deployment/nginx-deployment
   ```

---

## **Additional Commands**

- **Pause a Rolling Update**:
  ```bash
  kubectl rollout pause deployment/<DEPLOYMENT_NAME>
  ```

- **Resume a Paused Update**:
  ```bash
  kubectl rollout resume deployment/<DEPLOYMENT_NAME>
  ```

---

### **Deprecated Command (For Older Kubernetes Versions)**
If you're using an older version of Kubernetes, the `kubectl rolling-update` command works for **ReplicationControllers**, not Deployments:
```bash
kubectl rolling-update <OLD_RC_NAME> <NEW_RC_NAME> --image=<IMAGE>
```

But it's highly recommended to migrate to **Deployments** for better scalability and modern features.