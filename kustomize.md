## <mark>**Kustomize**</mark>

*   Kustomize simplifies templating without strange expressions
*   [Refer Here](https://kustomize.io/) for official docs
*   [Refer Here](https://kubernetes.io/docs/tasks/manage-kubernetes-objects/kustomization/) for kustomize documents
*   [Refer Here](https://kubernetes.io/docs/tasks/manage-kubernetes-objects/kustomization/)
*   [Refer Here](https://github.com/kubernetes-sigs/kustomize/tree/master/examples/multibases) for multi base

---
---

## <mark>**kustomize folder structure**</mark>

<img src='images\img_38.png' alt='folder structure' width='200'>

---
---

### <mark>**base**</mark>

**deployment.yaml**
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: preschool
  labels:
    app: preschool
spec:
  minReadySeconds: 10
  replicas: 3
  selector:
    matchLabels:
      app: preschool
  template:
    metadata:
      name: preschool
      labels:
        app: preschool
    spec:
      containers:
        - name: preschool
          image: shaikkhajaibrahim/preschool:1.1
          resources:
            requests:
              cpu: 100m
              memory: 100Mi
            limits:
              cpu: 250m
              memory: 300Mi
          ports:
            - containerPort: 80
          startupProbe:
            httpGet:
              path: /preschool
              port: 80
```

**service.yaml**

```yaml
apiVersion: v1
kind: Service
metadata:
  name: preschool-svc
spec:
  type: ClusterIP
  selector:
    app: preschool
  ports:
    - name: preschool-port
      port: 80
      targetPort: 80
```

**kustomization.yaml**

```yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
resources:
  - service.yaml
  - deployment.yaml
```

---

### <mark>**overlays**</mark>

#### **dev**

**deployment.yaml**

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: preschool
  labels:
    app: preschool
spec:
  minReadySeconds: 10
  replicas: 1
```

**kustomization.yaml**

```yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
resources:
- ../../base
namePrefix: dev-
patches:
  - path: deployment.yaml  # Path to your patch file
    target:
      kind: Deployment           # Specify the kind of resource
      name: preschool   # The name of the resource you want to patch
```

---

### qa

**deployment.yaml**

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: preschool
  labels:
    app: preschool
spec:
  minReadySeconds: 10
  replicas: 5
```

**kustomization.yaml**

```yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
resources:
- ../../base
namePrefix: qa-
patches:
  - path: deployment.yaml  # Path to your patch file
    target:
      kind: Deployment           # Specify the kind of resource
      name: preschool   # The name of the resource you want to patch | or |
# patchesStrategicMerge:
#   - deployment.yaml   # depreciated way
```

### **Applying patches**

```bash
kubectl apply -k overlays/dev
```