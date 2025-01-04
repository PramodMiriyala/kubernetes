## <mark>**Story of Kubernetes (K8s)**</mark>

### **1. Monolithic Systems (Previous Generation)**

- Let's imagine we are building an **e-commerce system**.

<img src="images/img_01.png" alt="E-commerce System" width="400" />

- The system consists of multiple modules, such as:
  - **User Registration and Management**
  - **Administration**
  - **Catalog**
  - **Warehousing**
  - **Logistics**
  - **Cart**
  - **Payment**
  - **Notifications**

#### **Challenges with Monolithic Systems**

1. **Scaling Issues:**
   - During peak times like a seasonal sale, a large number of users access the system simultaneously.
   - To handle this, we need to scale up servers hosting the monolithic application.

   <img src="images/img_02.png" alt="Scaling Challenges" width="400" />

2. **Application Updates:**
   - For **zero downtime updates**, additional servers are required.
   - Rollout involves updating each server one by one while keeping at least one running.
   - **Rollback** becomes complex if issues arise in the new version, requiring expertise.

---

### **2. Transition to Microservices**

- Applications are **decomposed into smaller, independently runnable services**. 
  - Each service manages a specific module (e.g., user management, payment, notifications).
  - Services can be updated, deployed, and scaled independently.

#### <mark>**How Kubernetes (K8s) Emerged (origin)**</mark>

- Google has a long history of running **containers** internally.
- They built orchestration systems to manage containers effectively:
  - **OMEGA**
  - **BORG**

- With the release of Docker, containers became widely adopted. 
- Leveraging their experience, Google developed an orchestration system called **Kubernetes**, written in **Go**, and made it open source.

#### **What is Kubernetes?**
- Kubernetes (K8s) is an **open-source system** that automates:
  - Deployment
  - Scaling
  - Management of containerized applications
    - Key Aspects of Kubernetes Management of Containerized Applications:

| **Aspect**                     | **Description**                                                                                                                                                           |
|--------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Container Lifecycle Management** | Kubernetes ensures containers are running as expected by continuously monitoring their health.                                                                           |
|                                | Automatically restarts containers that fail or become unresponsive.                                                                                                     |
|                                | Deletes containers that are no longer needed based on workload changes.                                                                                                 |
| **Self-Healing**               | Detects and replaces failed nodes or containers.                                                                                                                        |
|                                | Reschedules containers on healthy nodes in the cluster.                                                                                                                |
| **Configuration Management**    | Uses declarative configurations (YAML/JSON files) to define the desired application state.                                                                              |
|                                | Allows easy updates by simply modifying the configuration files.                                                                                                       |
|                                | Tracks and enforces the desired state across the cluster.                                                                                                              |
| **Resource Optimization**       | Distributes workloads evenly across nodes using resource requests and limits.                                                                                            |
|                                | Ensures optimal utilization of CPU and memory resources.                                                                                                               |
|                                | Supports scaling of containers up or down based on real-time resource usage or custom metrics.                                                                          |
| **Networking and Load Balancing** | Automatically creates and manages internal networking for communication between containers.                                                                             |
|                                | Provides built-in load balancing to distribute external traffic evenly among available containers.                                                                        |
| **Rolling Updates and Rollbacks** | Supports rolling updates to deploy new versions of applications without downtime.                                                                                       |
|                                | Allows rollbacks to previous stable versions if issues arise.                                                                                                          |
| **Logging and Monitoring**      | Integrates with logging and monitoring tools (e.g., Prometheus, Grafana) to track container performance and health.                                                     |
|                                | Provides detailed insights into container behavior and cluster operations.                                                                                              |

K8s focuses on **running containers in production scenarios**.

#### **Alternatives to Kubernetes:**
- **Docker Swarm**
- **Apache Mesos**
- **AWS ECS (Elastic Container Service)**

---
---

## <mark>**Kubernetes Architecture**</mark>

- A Kubernetes cluster is a **combination of multiple nodes**, categorized into:
  1. **Master Node**:
     - Manages the cluster.
     - Handles scheduling, orchestration, and management.
  2. **Worker Nodes**:
     - Run the application workloads.
     - Containers are hosted and executed here.

[phippy and friends](https://www.cncf.io/phippy/the-childrens-illustrated-guide-to-kubernetes/)

[Phippy Goes to the Zoo](https://www.cncf.io/phippy/phippy-goes-to-the-zoo-book/)

**<mark>For a fun introduction to microservices, check out the</mark>** [Kubernetes Comic Book by Google](https://cloud.google.com/kubernetes-engine/kubernetes-comic).

### **Introduction-Kubernetes**

#### **Overview of Containers**

![image](images\img_03.png)


| **Question or Concern about containers**                                             | **Solution through Kubernetes**                                                                                                                                                                                                                      |
|---------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Are containers production-ready?**                                | Kubernetes automates the deployment, scaling, and management of containerized applications, ensuring they are robust and reliable for production environments.                                                                                         |
| **What happens if a container or Docker host goes down?**          | Kubernetes provides self-healing capabilities by automatically restarting failed containers, rescheduling them on healthy nodes, and redistributing workloads to maintain application availability.                                                       |
| **How to make containers available 24/7?**                         | Kubernetes supports high availability through automated failover and load balancing, ensuring that applications remain accessible even during node failures or maintenance.                                                                              |
| **How to handle loads during peak times?**                          | Kubernetes enables horizontal scaling by automatically adding or removing containers based on real-time resource usage or custom metrics, allowing applications to handle increased traffic efficiently.                                                  |
| **How to replace containers without downtime?**                     | Kubernetes supports rolling updates, allowing new versions of applications to be deployed gradually without interrupting service. If issues arise, it can also roll back to previous stable versions seamlessly.                                          |
| **How to monitor containers?**                                      | Kubernetes integrates with various monitoring tools (e.g., Prometheus, Grafana) to provide insights into container performance and health, enabling proactive management of applications.                                                                |

<mark>**Kubernetes Provides** </mark>

| **Feature**                    | **Description**                                                                                                   |
|---------------------------------|-------------------------------------------------------------------------------------------------------------------|
| **Service Discovery & Load Balancing** | Automatically assigns DNS names to services and balances traffic to containers within those services.            |
| **Storage Orchestration**       | Manages storage for containers, including dynamic provisioning, persistent storage, and volume attachments.        |
| **Automated Rollouts and Rollbacks** | Enables rolling updates to applications with zero downtime and easy rollback to previous stable versions if needed. |
| **Automated Bin Packing**       | Places containers based on resource requirements and constraints, optimizing resource usage across the cluster.     |
| **Self-Healing**                | Detects and replaces failed containers or nodes to maintain the desired state of the system.                       |
| **Secret & Configuration Management** | Manages sensitive data (e.g., passwords, API keys) and configuration settings securely, separate from application code. |
| **Horizontal Scaling**          | Automatically adjusts the number of running containers (pods) based on real-time resource usage or custom metrics.  |
| **Cluster Management**          | Manages the lifecycle of the cluster, including scaling up or down and maintaining healthy nodes.                   |
| **Multi-Tenancy**               | Uses **namespaces** to logically partition resources and manage multiple teams or projects within the same cluster.  |
| **Monitoring and Logging**      | Integrates with tools like Prometheus and Grafana for performance tracking and cluster insights.                    |
| **Custom Resource Definitions (CRDs)** | Extends Kubernetes' functionality by allowing you to define and manage custom resources.                        |
| **Network Policies**            | Defines rules for controlling traffic flow between pods or services, ensuring secure communication.                 |

![image](images\img_04.png)

* We express our **desired state in yaml or imperative command** and **use a client (ex: kubectl) to communicate with k8s** and k8s does the rest

### **Kubernetes Master and Node Components - Explanation**

<img src="images/img_05.png" alt="Deployment Diagram" width="400" />

* Kubernetes master runs on Linux nodes

#### **Master Components**

* **kube-api Server**
  - The **kube-api Server** is central to Kubernetes, acting as the communication hub for all components within the system.  
  - It serves as the **frontend of the Kubernetes control plane** and is responsible for handling requests.  
  - The **kube-api Server exposes a REST API**, enabling interactions with the cluster.  
  - Users and tools interact with this component primarily through the `kubectl` command-line tool, using **YAML manifests** to define the desired cluster state.

* **etcd**
  * Stores the entire configuration and state of the cluster. A backup of Kubernetes is essentially a backup of etcd.
  * etcd is consistent and highly available distributed key-value store.

- **Scheduler**  
  - The **Kubernetes Scheduler** is responsible for watching for newly created tasks (e.g., pods) that have no assigned node.  
  - It evaluates the resource requirements of these tasks and assigns them to **healthy nodes** in the cluster based on various factors such as resource availability, constraints, and policies.  
  - The scheduler ensures optimal utilization of cluster resources while maintaining the desired state.

- **Controller-Manager**  
  - The **Controller-Manager** is responsible for maintaining the desired states specified in the manifest files.  
  - Although it appears as a single component, it contains multiple controllers, each with a specific function:  
    - **Node Controller**: Monitors nodes in the cluster and takes action when a node goes down.  
    - **Replication Controller**: Ensures the correct number of pods are running for each replication controller object.  
    - **Endpoints Controller**: Populates the **Endpoints** object, which is used to link services with their corresponding pods.

- **Cloud-Controller-manager**
  - If you run the Kubernetes on a supported **cloud platform** such as AWS, Azure or Google, your **control plane runs the Cloud-Controller-Manager**.
  - It is responsible for underlying cloud specific controllers.

<img src="images/img_06.png" alt="Deployment Diagram" width="400" />

- **kubelet**  
  - The **kubelet** is an agent that runs on each node in the cluster.  
  - It **watches for instructions from the API Server** and executes tasks (e.g., managing pods and containers) assigned to the node.  
  - If it cannot run the assigned task, it reports back to the master, allowing the control plane to decide the next steps.  
  - The kubelet is also responsible for the **node registration process**, ensuring the node is part of the cluster and ready to receive workloads.

- **Container Runtime**  
  - The **Container Runtime** is software responsible for running containers on each node in the Kubernetes cluster.  
  - It pulls container images, runs containers, and manages their lifecycle.  
  - Some commonly used container runtimes include:
    - **Docker**, **containerd**, **CRI-O**, **rktlet**

- **kube-proxy**  
  - The **kube-proxy** maintains network rules on each node in the cluster.  
  - It is responsible for **networking on nodes**, handling network traffic between pods, services, and external clients.  
  - kube-proxy ensures that traffic is properly routed, enabling communication within the cluster and between services.

- **Cluster DNS**  
  - Every **Kubernetes Cluster** includes an internal DNS service for name resolution within the cluster.  
  - The DNS service has a **static IP address** that is hardcoded into every pod, ensuring that all pods know how to find the DNS server.  
  - **Services**, **StatefulSets**, and **Pods** are registered with the **Cluster DNS**, allowing for seamless internal name resolution.  
  - The **Cluster DNS** is based on **CoreDNS**, which is the default DNS provider for Kubernetes.

---
---
Here are the refined notes for **Kubernetes Installation (Self-hosted)**:

---

### <mark>**K8s Installation (Self-hosted)**</mark>

* Refer **k8s_Selfhosted_setup.md** for k8s Self-Hosted Setup

---
---

## **Kubernetes Major Workloads**

### <mark>**Pod**</mark>

- [Official Docs](https://kubernetes.io/docs/concepts/workloads/pods/)
- **Pods** can contain one or more closely associated containers.
- Each **Pod** gets a unique IP address, which is shared among the containers inside it.
- Pods can contain two types of containers:
  - <mark>**Init containers**</mark>: These containers are created in a sequence and run to completion. They are typically used for precondition checks before the main containers run.
    - Refer **Init_containers.md** for more details.
  - <mark>**Containers**</mark>: These are the main application containers, which are created in parallel and are expected to run continuously.
- The **desired state of a Pod** is defined by the containers running inside it. If any container fails, Kubernetes will continuously attempt to restart it to maintain the desired state.
  - Desired State of a Pod:
    - The number and type of containers that should be running.
    - The images the containers should use.
    - The environment variables, volumes, Ports, resource requests, and limits and other settings[configurations for health checks, liveness/readiness probes, security settings (like user privileges or service accounts), and any other container-level or Pod-level settings.]
- There is a special type of container called **ephemeral containers**
  - <mark>**ephemeral containers**</mark> are a special type of container in Kubernetes that are intended primarily for debugging purposes. Unlike regular containers in a Pod, ephemeral containers do not have a fixed lifecycle and are added to a running Pod for temporary use. They can be used to help troubleshoot or debug issues in a Pod that is already running.

<img src="images/img_11.png" alt="Deployment Diagram" width="400" />

---

## **components**
### <mark>**NameSpaces**</mark>
* Namespaces allow to split-up resources into different groups.
* Resource names should be unique in a namespace
* We can use namespaces to create multiple environments like dev, staging and production etc
* Kubernetes will always list the resources from default namespace unless we provide exclusively from which namespace we need information from.
-   Resources are classified into two scopes
    -   Namespace scoped resources:
        -   Namespace true indicates namespace scoped resources
    -   Cluster scoped resources
        -   Namespaced false indicates cluster scoped resources

<img src="images/img_24.png" alt="Deployment Diagram" width="600" />

```bash
kubectl api-resources

# List Namespaces
kubectl get ns 

# Craete Namespace
kubectl create namespace <namespace-name>
kubectl create namespace dev1

# List Namespaces
kubectl get ns 

# Deploy All k8s Objects
kubectl apply -f kube-manifests/ -n dev1

# List Services
kubectl get svc -n dev1

# Delete namespaces dev1 & dev2
kubectl delete ns dev1
```

<img src="images/img_27.png" alt="Deployment Diagram" width="1000" />

---
---

## **Controllers**

### <mark>**ReplicaSet**</mark>

- [Official Docs](https://kubernetes.io/docs/concepts/workloads/controllers/replicaset/)
- ReplicaSets are used to ensure that a specified number of identical Pods are running at any given time.
- If any Pod fails or is deleted, the ReplicaSet will create a new one to maintain the desired number of replicas.
- Key Features of ReplicaSet:
  - Maintain Desired Number of Pods
  - Self-Healing
  - Scaling
  - Label Selector

<img src="images/img_12.png" alt="Deployment Diagram" width="400" />

### <mark>**Deployment**</mark>

-   Deployments create replica sets, replicasets create pods which in turn runs the containers
-   Deployments are suitable for stateless applications
-   Deployments come with two strategies
    -   Recreate
    -   RollingUpdates (Default)
-   In Rolling updates
    -   We can rollout New versions
    -   undo rollout (rollbacks)
- [Official Docs](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/)
- For deployment **to record the change cause** lets use the **annotation** [Refer here](https://kubernetes.io/docs/reference/labels-annotations-taints/#change-cause)
- To find the **deployment status** we use **kubeclt rollout**
- To deploy the new version change the tag and change cause annotation

<img src="images/img_13.png" alt="Deployment Diagram" width="350" />

- A **Deployment** manages ReplicaSets and enables **scaling of applications**, as well as **rolling updates** and **rollbacks** through **versioning**.
---

### <mark>**DaemonSet**</mark>  

- [Official Docs](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/)  
 
-   Daemonsets are used to run a pod on each node or selected nodes
-   They are useful for running agent like softwares in container
-   Daemonset support rolling updates like deployments
-   [Refer Here](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/) for offical docs

<img src="images/img_14.png" alt="DeamonSet Diagram" width="400" />

- **Use Cases**:  
  - Running background processes like log collection (e.g., Fluentd or Logstash).  
  - Monitoring agents (e.g., Prometheus Node Exporter).  
  - Networking plugins (e.g., Flannel or Calico).  
- **Independent of Desired State Scaling**:  
  Unlike ReplicaSets or Deployments, the number of Pods is tied to the number of nodes rather than a fixed desired state.

```yaml
---
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: hello-ds
spec:
  minReadySeconds: 5
  selector:
    matchLabels:
      app: agent
  template:
    metadata:
      labels:
        app: agent
    spec:
      containers:
        - name: logagent
          image: fluent/fluentd:edge-debian
          resources:
            requests:
              memory: 64Mi
              cpu: 200m
            limits:
              memory: 128Mi
              cpu: 300m
          ports:
            - containerPort: 9880
              name: fluentd
```
---

### <mark>**Jobs and CronJobs**</mark>

-   [Refer Here](https://kubernetes.io/docs/concepts/workloads/controllers/cron-jobs/) for cronjob demo
-   Lets write a cronjob which runs every working day at 11:30 PM  

```yaml
---
apiVersion: batch/v1
kind: CronJob
metadata:
  name: transaction-cron
spec:                           # cron-job spec
  schedule: "30 23 * * 1-5"
  jobTemplate:
    metadata:
      labels:
        app: tx-checker
    spec:                       # Job spec
      template:
        metadata:
          labels:
            app: tx-checker
        spec:                   # Pod spec
          containers:
            - name: tx-checker
              image: alpine
              args: # replace with script that does the job
                - sleep
                - 30s
          restartPolicy: OnFailure
```
---


### <mark>**StatefulSet**</mark>  

- [Official Docs](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/)  

- StatefulSets are used to manage stateful applications that require stable network identities and persistent storage.

### **Key Features**  
1. **Unique Pod Identity**:  
   Each Pod in a StatefulSet gets a predictable name in the format `statefulset-name-index` (e.g., `my-app-0`, `my-app-1`).  
2. **Stable Network Identity**:  
   Each Pod maintains a unique and stable network hostname, even after being rescheduled.  
3. **Ordered Deployment and Scaling**:  
   Pods are created or terminated in a sequential order, ensuring controlled deployment and updates.  
4. **Persistent Storage**:  
   Each Pod can have its own PersistentVolume, which is retained even after the Pod is deleted.  
5. **Rolling Updates**:  
   StatefulSets support updates to Pods, maintaining order and state consistency.

### **Use Cases**  
- **Databases**: PostgreSQL, MySQL, MongoDB.  
- **Message Queues**: Kafka, RabbitMQ.  
- **Distributed Systems**: Elasticsearch, Cassandra.  
- Any application requiring stable storage or networking.

### **Lifecycle Management**  
1. **Scaling**:  
   Pods are scaled one at a time, respecting their order (e.g., `my-app-0` must be running before `my-app-1` starts).  
2. **Updates**:  
   Pods are updated in sequence to minimize disruption.  
3. **Deletion**:  
   Pods are deleted in reverse order to maintain state integrity.

### **How StatefulSets Differ from ReplicaSets**  
| Feature                | StatefulSet                          | ReplicaSet                 |
|------------------------|--------------------------------------|---------------------------|
| Pod Identity           | Unique, stable hostname             | Generic, ephemeral hostname|
| Storage                | Persistent, per-Pod volumes         | Shared or none            |
| Deployment Order       | Sequential                          | Parallel                  |
| Use Cases              | Stateful apps, databases, queues    | Stateless apps            |

### **Benefits**  
- Ensures data consistency and stable connections across cluster nodes.  

---

## <mark>**Label**</mark>

- Labels are key-value pairs attached to Kubernetes objects.
- Kubernetes uses labels to organize and query resources efficiently.

---

## <mark>**Service**</mark>

  A **Service** is a Kubernetes resource that provides a stable network endpoint to a group of dynamically changing Pods.

- **Purpose**:  
  - It abstracts the underlying Pods to provide a consistent way to access them.  
  - Ensures reliable communication between components, even if Pods are recreated or scaled.

- **Key Features**:  
  1. **Stable Network Identity**:  
     - Services assign stable IP addresses and DNS names, ensuring consistent access.  
  2. **Dynamic Pod Management**:  
     - Automatically adapts to changes in the Pods (e.g., scaling or replacements).  
  3. **Selectors**:  
     - Services use **label selectors** to identify the set of Pods they manage.  
  4. **Load Balancing**:  
     - Distributes traffic evenly across the associated Pods.

- **Types of Services**:  
  1. **ClusterIP**:  
     - Default type; exposes the Service internally within the cluster.  
  2. **NodePort**:  
     - Exposes the Service on a static port on each node.  
  3. **LoadBalancer**:  
     - Creates an external load balancer to expose the Service.  
  4. **ExternalName**:  
     - Maps a Service to an external DNS name.

- **Use Case**:  
  - Frontend application accessing a backend service through a consistent endpoint, regardless of backend Pod changes.

---
---

## **Kubernetes API Server and Clients**

### **Overview**  
- The **Kubernetes API Server** acts as the central management component, exposing APIs for all cluster operations.  
- **kubectl** is the primary CLI tool for interacting with the API Server.

---

### <mark>**kubectl**</mark> 
- Uses the `~/.kube/config` file to connect to the API Server.  
  - **References**:  
    - [Kubectl Reference Docs](https://kubernetes.io/docs/reference/kubectl/)  
    - [Kubectl Quick Reference Cheatsheet](https://kubernetes.io/docs/reference/kubectl/quick-reference/)  

- **Resource Creation Approaches**:  
  1. **Imperative**:  
     - Directly execute commands to create or modify resources.  
     - Example:  
       ```bash
       kubectl run nginx --image=nginx
       ```  
     - Best for ad-hoc or one-time tasks.  

  2. **Declarative**:  
     - Write YAML manifests defining the desired state and apply them.  
     - Example:  
       ```bash
       kubectl apply -f deployment.yaml
       ```  
     - Ideal for automation, repeatability, and version control.  

     - <mark>Refer yaml_syntax.md for yaml syntax</mark> 
---

### ** Kubernetes API Features**  
- **Client Libraries**:  
  - Kubernetes offers libraries in various programming languages (e.g., Python, Go).  
  - Reference: [Kubernetes Client Libraries](https://kubernetes.io/docs/reference/using-api/client-libraries/)  

- **API Versioning**:  
  - Ensures backward compatibility and smooth transitions across Kubernetes versions.  
  - API version format:  
    - `APIGROUP/version` (e.g., `apps/v1`) for non-core APIs.  
    - `version` (e.g., `v1`) for core APIs.  
  - Reference: [API Versioning Guide](https://kubernetes.io/docs/reference/using-api/#api-versioning)  

- **API Groups**:  
  - Organize related resources. Common groups include:  
    - `core`: Core Kubernetes objects (e.g., Pods, Services).  
    - `apps`: Workloads (e.g., Deployments, StatefulSets).  
    - `batch`: Batch jobs and CronJobs.  

---

### <mark>**Manifest Structure**</mark>
- A typical YAML manifest includes:  
  1. `apiVersion`: Specifies the API version (e.g., `apps/v1`).  
  2. `kind`: Defines the resource type (e.g., Pod, Service).  
  3. `metadata`: Holds information like name, labels, and annotations.  
  4. `spec`: Describes the desired state of the resource.  

- Upon execution, Kubernetes adds a `status` field to the resource, reflecting its current state.

---

### **Commands**  
- Check cluster configuration:  
  ```bash
  kubectl config view
  ```
- Get resources:  
  ```bash
  kubectl get <resource>
  ```
- Describe a resource:  
  ```bash
  kubectl describe <resource> <name>
  ```
---
---

## <mark>**Writing Kubernetes Manifests**</mark>

### **Key Concepts**
- Kubernetes manifests define resources in YAML format, strictly structured according to [API References](https://kubernetes.io/docs/reference/).  
- For detailed API reference of version 1.31, check [here](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.31/).

---

### **Activity 1: Create a Basic Pod**
- **Pod Name**: `hello-pod`  
- **Container**: nginx with version `1.27`.

**Manifest Example**:  
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: hello-pod
spec:
  containers:
  - name: web
    image: nginx:1.27
```

**Commands**:  
1. Create the Pod:  
   ```bash
   kubectl apply -f <filename.yaml>
   ```
2. View Pod Information:  
   ```bash
   kubectl get pods <pod-name>
   kubectl get pods <pod-name> -o wide
   kubectl describe pods <pod-name>
   kubectl get pods <pod-name> -o yaml
   ```
3. Watch Pod Status in Real-Time:  
   ```bash
   kubectl get pods -w
   ```

---

### **Activity 2: Pod with Two Containers**
- **Pod Name**: `activity-2`  
- **Containers**:  
  1. nginx: `1.27`  
  2. alpine with command `sleep 1d`.

**Manifest Example**:  
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: activity-2
spec:
  containers:
  - name: web
    image: nginx:1.27
  - name: sidecar
    image: alpine
    args: ["sleep", "1d"]
```

---

### **Activity 3: Pod with a Container that Exits**
- Kubernetes will restart Pods in a **CrashLoopBackOff** state due to its self-healing feature.  

- Example: Pod with an alpine container executing `sleep 10s`.

### **Init Containers**
- **Purpose**: Perform preconditions or preparatory steps before the main container starts. 
- Init containers run sequentially; each must complete successfully before the next one starts.

**Activity 4: Pod with Init Containers**  
- **Pod Spec**:  
  - Containers: nginx and alpine (`sleep 1d`).  
  - Init Containers:  
    - init1 (alpine, `sleep 10s`)  
    - init2 (alpine, `sleep 10s`).  

**Manifest Example**:  
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: activity-4
spec:
  initContainers:
  - name: init1
    image: alpine
    args: ["sleep", "10s"]
  - name: init2
    image: alpine
    args: ["sleep", "10s"]
  containers:
  - name: web
    image: nginx:1.27
  - name: sidecar
    image: alpine
    args: ["sleep", "1d"]
```

---

### **Activity 5: Pod with Environment Variables**
- **Pod Name**: `env-pod`  
- **Container**: alpine (`sleep 1d`)  
- **Environment Variables**:  
  - `USERNAME=admin`  
  - `PASSWORD=admin@123`.  

**Manifest Example**:  
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: env-pod
spec:
  containers:
  - name: test
    image: alpine
    args: ["sleep", "1d"]
    env:
    - name: USERNAME
      value: "admin"
    - name: PASSWORD
      value: "admin@123"
```

Equivalent Docker Command:  
```bash
docker run -e "USERNAME=admin" -e "PASSWORD=admin@123" alpine sleep 1d
```

Getting Environment Variables
```bash
kubectl exec env-pod -c test -- env
# or
kubectl exec -it env-pod -- /bin/sh
printenv # Once Inside the Container
```
---

### **Adding Labels to Pods**
- Labels are key-value pairs used to categorize and organize Kubernetes objects.

**Activity**:  
- Pod Name: `web`  
- Labels:  
  - `env: dev`  
  - `app: web`  
  - `release: v1.6.9`.  

**Manifest Example**:  
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: web
  labels:
    env: dev
    app: web
    release: v1.6.9
spec:
  containers:
  - name: web
    image: nginx:1.27
```


---

### **Label Selectors**
- Label selectors enable efficient resource querying based on labels.  
- Reference: [Kubernetes Label Selectors](https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/#label-selectors).

---
---

## <mark>**Managed kubernetes cluster**</mark>

Managed Kubernetes clusters simplify operating Kubernetes by outsourcing the management of the control plane to cloud providers. 
#### key points:

1. **Offered by Cloud Providers**:
   - Services like AWS EKS, Azure AKS, Google GKE, and others provide managed Kubernetes clusters.
   - These services reduce the operational burden of managing Kubernetes infrastructure.

2. **Managed Control Plane**:
   - The control plane (API server, scheduler, controller manager, etc.) is maintained by the cloud provider.
   - Users only manage worker nodes and the workloads running on them.
   - This setup provides a consistent, scalable environment without the need to handle complex installations or updates.

3. **Black Box Nature**:
   - The control plane is treated as a "black box"; users don’t have direct access to its internals.
   - This abstraction allows teams to focus on application deployment and management rather than Kubernetes internals.

<img src="images/img_18.png" alt="IMAGE" width="400" />
---


### <mark>**Azure Kubernetes Services (AKS)**</mark>

* AKS is managed k8s offered by Azure [Refer Here](https://learn.microsoft.com/en-us/azure/aks/what-is-aks)
* Lets setup AKS Cluster
  * Pre-reqs:
    * Azure CLI is installed and configured
* [Refer Here](https://learn.microsoft.com/en-us/azure/aks/learn/quick-kubernetes-deploy-cli) for steps
* **Azure CLI installation Script**(userdata) on a Debian-based Linux distribution:

```bash
# Update System Package Index
sudo apt-get update
# Install Required Packages
sudo apt-get install apt-transport-https ca-certificates curl gnupg lsb-release -y
# Prepare for the Azure CLI Repository
sudo mkdir -p /etc/apt/keyrings
# Add Microsoft’s GPG Key
curl -sLS https://packages.microsoft.com/keys/microsoft.asc |
  gpg --dearmor | sudo tee /etc/apt/keyrings/microsoft.gpg > /dev/null
sudo chmod go+r /etc/apt/keyrings/microsoft.gpg
# Define the Azure CLI Repository
AZ_DIST=$(lsb_release -cs)
echo "Types: deb
URIs: https://packages.microsoft.com/repos/azure-cli/
Suites: ${AZ_DIST}
Components: main
Architectures: $(dpkg --print-architecture)
Signed-by: /etc/apt/keyrings/microsoft.gpg" | sudo tee /etc/apt/sources.list.d/azure-cli.sources
# Update Package Index Again
sudo apt-get update
# Install Azure CLI
sudo apt-get install azure-cli -y
```

* **Commands to create AKS cluster**

```bash
#!/bin/bash

# bash variables 
export MY_RESOURCE_GROUP_NAME="myAKSResourceGroup" # Replace with your desired resource group name
export REGION="eastus"                             # Specify Azure region (e.g., eastus, westus, etc.)
export MY_AKS_CLUSTER_NAME="myAKSCluster"          # Replace with your desired AKS cluster name
export MY_DNS_LABEL="mydnslabel"                   # Optional: Specify a unique DNS label if required

# PowerShell variables
# $MY_RESOURCE_GROUP_NAME = "myAKSResourceGroup"   # Replace with your desired resource group name
# $REGION = "eastus"                              # Specify Azure region (e.g., eastus, westus, etc.)
# $MY_AKS_CLUSTER_NAME = "myAKSCluster"          # Replace with your desired AKS cluster name
# $MY_DNS_LABEL = "mydnslabel"                   # Optional: Specify a unique DNS label if required
# Replace \ with `

# Step 1: Create a resource group
az group create \
  --name $MY_RESOURCE_GROUP_NAME \
  --location $REGION

# Step 2: Create an AKS cluster
az aks create \
  --resource-group $MY_RESOURCE_GROUP_NAME \
  --name $MY_AKS_CLUSTER_NAME \
  --node-count 1 \
  --node-vm-size "Standard_B2ms" \
  --node-osdisk-size 30 \
  --generate-ssh-keys

# Step 3: Install kubectl (if not already installed)
az aks install-cli

# Step 4: Get kubeconfig to access the cluster
az aks get-credentials \
  --resource-group $MY_RESOURCE_GROUP_NAME \
  --name $MY_AKS_CLUSTER_NAME
```
---
---

### <mark>**Resources**: **requests** and **limits**</mark>

In Kubernetes, **requests** and **limits** manage container resource allocation (CPU, memory):

- **Requests** define the amount of resources a container needs to start and run. The Kubernetes scheduler uses these values to place containers on nodes with sufficient capacity.
- **Limits** specify the maximum resources a container can consume. If it exceeds this limit, it can be throttled (CPU) or terminated (memory).

By setting both requests and limits, Kubernetes ensures better resource management, preventing any container from overusing resources and causing instability.

For more, refer to the [Kubernetes documentation](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/).

---
---

## **Activity-1**  

### **Pod Definition** (Example):
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx-pod
  labels:
    app: 'nginx'
spec:
  containers:
    - name: nginx
      image: nginx:1.27-alpine
      resources:
        requests:
          cpu: "68m"
          memory: "68Mi"
        limits:
          cpu: "150m"
          memory: "200Mi"
      command:
        - "nginx"
      args:
        - "-g"
        - "daemon off;"
```

- **Purpose**: A simple Nginx pod configuration running the `nginx:1.27-alpine` image with defined CPU and memory resource limits and requests.
- **Note**: `command` and `args` ensure Nginx runs in the foreground (`daemon off`).


### **Syntax for Exposing a Pod**:
* **Important Note**: Exposing a pod directly is **not recommended** for production environments (use a Service instead).
  
```bash
kubectl expose pod <pod-name> --port=<port> --name=<svc-name>
```
---
#### Explanation of Flags:
- `<pod-name>`: The name of the pod you want to expose. It specifies the pod that the service will route traffic to.
  
- `--port=<port>`: The port on which the service will be exposed to clients (external access).  
  **Example**: If the service is exposed on port `80`, clients will use port `80` to access it.

- `--name=<svc-name>`: The name of the service that will be created to expose the pod.  
  **Example**: `--name=nginx-service` creates a service named `nginx-service`.

---
### **Syntax for Port Forwarding**:
```bash
kubectl port-forward <pod-name> <local-port>:<pod-port>
```

#### Explanation of Flags:
- `<pod-name>`: The name of the pod you want to forward the port from.
  
- `<local-port>`: The port on your **local machine** that you want to bind to and use for accessing the pod.

- `<pod-port>`: The port inside the pod to which traffic will be forwarded. This should match the port the application inside the pod is listening on (e.g., Nginx listens on port `80` by default).

---
### **Best Practices**:

1. **Exposing Pods**:  
   - <mark>**Not recommended**</mark> for production use. Instead, use **Deployments** to manage pods, as they provide better scalability, availability, and management features.

2. **Port Forwarding**:  
   - Ideal for **testing** and **debugging** when you need to access services or pods locally without exposing them externally.

3. **Service Creation**:  
   - Use the `kubectl expose` command for creating **services** to provide stable network access to pods.
   - Prefer `ClusterIP` for internal services or `LoadBalancer` for external services (if supported by the cloud provider).

Let me know if you'd like further clarification on any of these concepts!

---
---
### <mark>**Annotations**</mark>
* In Kubernetes (K8s), annotations are key-value pairs used to attach arbitrary, non-identifying metadata to objects like pods, services, deployments, or nodes. Unlike labels, annotations are not used for selection or grouping but provide additional information useful for tools, scripts, or third-party integrations.

[Refer here](https://kubernetes.io/docs/reference/labels-annotations-taints/) for well known annotaions

#### **Examples**
##### **1. Deployment with Change-Cause Annotation**

Annotations are commonly used in deployments to record version changes or metadata for tracking updates.

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: lib-deployment
  annotations:
    kubernetes.io/change-cause: "version-v01"
```
##### **2. LoadBalancer Service with Annotations**

Annotations can also be applied to services, especially for configuring LoadBalancer behavior or external integrations (e.g., cloud-specific annotations).

```yaml
apiVersion: v1
kind: Service
metadata:
  name: lib-service
  annotations:
    networking.gke.io/load-balancer-type: "External"
```
---
### <mark>**labels**</mark>
The importance of labels in a ReplicaSet can be summarized as follows:

* Pod Selection: Labels help the ReplicaSet identify and manage specific pods by matching labels defined in its selector.
* Scaling: Labels ensure that when scaling, the ReplicaSet can find and adjust the right pods to maintain the desired replica count.
* Targeted Management: By using labels, the ReplicaSet can efficiently manage pods even if there are multiple types of pods in the same cluster.


## **Activity-2**:
* **Lets deploy spc using replicaset and a service of type load balancer**

```yaml
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: spc-rs
  labels:
    app: spc
spec:
  minReadySeconds: 10
  replicas: 2
  selector:
    matchLabels:
      app: spc
  template:
    metadata:
      name: spc-pod
      labels:
        app: spc
    spec:
      containers:
        - name: spc
          image: shaikkhajaibrahim/spcjan2024:1.0
          ports:
            - containerPort: 8080
              name: spc-app-port
              protocol: TCP
          readinessProbe:
            httpGet:
              path: /
              port: spc-app-port
            initialDelaySeconds: 5
            periodSeconds: 10
          resources:
            requests:
              cpu: "150m"
              memory: "150Mi"
            limits:
              cpu: "300m"
              memory: "350Mi"
          workingDir: /
          command:
            - "java"
            - "-jar"
            - "/spring-petclinic-3.2.0-SNAPSHOT.jar"
      automountServiceAccountToken: false

---
apiVersion: v1
kind: Service
metadata:
  name: spc-svc
  annotations:
    networking.gke.io/load-balancer-type: "External"
spec:
  type: LoadBalancer
  selector:
    app: spc
  ports:
    - name: spc-svc-port
      port: 30102
      targetPort: spc-app-port
      protocol: TCP
```
---
**Deploy spc using replicaset and a service of type NodePort**

```yaml
# To get node ip's
kubectl get nodes -o wide
# To get Port
kubectl get svc <svc-name>
http://<node-ip>:<svc-port>
```


```yaml
# service with Type NodePort
---
apiVersion: v1
kind: Service
metadata:
  name: spc-svc
spec:
  type: NodePort
  selector:
    app: spc
  ports:
    - name: spc-svc-port
      port: 8080
      targetPort: spc-app-port
      protocol: TCP
```
---
---

## **Activity-3**
### **Deploying Library Application**
**Architecture:**

<img src="images/img_21.png" alt="Deployment Diagram" width="600" />

**Example Architecture**

<img src="images/img_22.png" alt="Deployment Diagram" width="1000" />

- **For deployment to record the change cause lets use the annotation** [Refer here](https://kubernetes.io/docs/reference/labels-annotations-taints/#change-cause)
- To find the deployment status we use **kubeclt rollout**
```bash
# deployment history
kubectl rollout history deployments <deploment-name>
# to roll back
kubectl rollout undo deployment --to-revision=2
```
- To access the application externally use nodeport or loadbalancer
- To deploy the new version change the tag and change cause annotation

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: web-deploy
  annotations:
    kubernetes.io/change-cause: "version v1.0"
```

![image](images\img_25.png)


<img src="images/img_23.png" alt="Deployment Diagram" width="500" />

---

* <mark>**Order of Creation :**</mark>
  * **Least Dependent to most dependent**
---
## <mark>**Config Maps and Secrets**</mark>

### <mark>**Config Maps**</mark>

-   [Refer Here](https://kubernetes.io/docs/concepts/configuration/configmap/) for official docs of config maps

```yaml
# config.yaml
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: users-db-config
data:
  POSTGRES_USER: user
  POSTGRES_PASSWORD: password
  POSTGRES_DB: usersdb

# deploy-pod template utilizing env (one key-value's at a time)
template:
  spec:
    containers:
      - name: usersdb
        image: postgres:15-alpine
        env:
          - name: POSTGRES_USER
            valueFrom:
              configMapKeyRef:
                name: users-db-config
                key: POSTGRES_USER


# deploy-pod template utilizing envFrom (all keys-value's at a time)
---
template:
  spec:
    containers:
      - name: usersdb
        image: postgres:15-alpine
        envFrom:
          - configMapRef:
              name: users-db-config
```

-   Config maps gives us flexibility to separate configuration from Pod

#### <u>**Kubernetes ConfigMap Usage Summary**</u>

**ConfigMaps** in Kubernetes allow injecting configuration data into Pods. There are **four ways** to use ConfigMaps:

1. **Inside container commands and args**  
2. **As environment variables**  
3. **As files in a read-only volume**  
4. **Dynamic runtime access using Kubernetes API**  

##### Key Point:
- **Static methods (1, 2, and 3)** require Pod restarts for changes to take effect.
- **Dynamic access (4)** enables real-time configuration updates.  

---

Let me know if you'd like an example for any of these methods! 🚀
### <mark>**Secrets**</mark>

<img src="images/img_26.png" alt="Deployment Diagram" width="400" />

-   The sensitive information is still in plain text, To solve this Secrets for k8s gives an **base64encoding** based approach to store sensitive information
-   [Refer Here](https://kubernetes.io/docs/concepts/configuration/secret/) for official docs of secrets

```yaml
# secrets.yaml
---
apiVersion: v1
kind: Secret
metadata:
  name: users-db-secrets
data:
  POSTGRES_USER: dXNlcg==
  POSTGRES_PASSWORD: cGFzc3dvcmQ=
  POSTGRES_DB: dXNlcnNkYg==

# deploy-pod template utilizing secretRef
---
template:
  spec:
    containers:
      - image: postgres:15-alpine
        name: usersdb
        envFrom:
          - secretRef:
              name: users-db-secrets
```

-   The **production approach** for storing sensitive information will be
    -   Use an **external secrets manager** like azure key vault, aws secrets manager, gcp secrets manager or hashicorp vault
    -   **Use secrets CSI Driver** of a vendor to get the sensitive information into k8s as storage


---
### <mark>**Health Checks or Probes in Kubernetes**</mark>

-   In K8s we have 3 types of Probes (checks)
    -   Liveness Probe:
        -   Determines if the container is running or not
        -   If Probe fails the container is restarted
    -   Readiness Probe
        -   Determines if the application is running or not
        -   If probe fails, this container will not recieve requests from service
    -   Startup Probe
        -   Determines if the container starup is complete or not
        -   If this probe fails no further probes are executed
-   [Refer Here](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/) for official docs
-   Configuring probes [Refer Here](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/#configure-probes)

```yaml
spec:
  containers:
    - containerPort: 8000
    livenessProbe:
      initialDelaySeconds: 3
      periodSeconds: 10
      successThreshold: 1
      failureThreshold: 3
      tcpSocket:
        port: 8000
    readinessProbe:
      initialDelaySeconds: 5
      periodSeconds: 10
      successThreshold: 1
      failureThreshold: 3
      httpGet:
        path: /docs
        port: 8000
    startupProbe:
      initialDelaySeconds: 2
      periodSeconds: 10
      successThreshold: 1
      failureThreshold: 3
      exec:
        command:
          - /bin/sh
          - -c
          - ps aux | grep uvicorn
```
---
### <mark>**Connecting from pod to the service running in a different name space**</mark>

```bash
# Direct DNS Access
<service-name>.<namespace>.svc.cluster.local
# curl http://my-svc.dev
```
---
## <mark>**Kubernetes Storage**</mark>

* Container Storage Interface (CSI) is a storage interface for k8s
* List of CSI drivers [Refer here](https://kubernetes-csi.github.io/docs/drivers.html)

<img src="images/img_28.png" alt="PVC_Claim_Diagram" width="1000" />

-   [Refer Here](https://kubernetes.io/docs/concepts/storage/persistent-volumes/) for official docs of PVs (persitent volume)
-   [Refer Here](https://kubernetes.io/docs/concepts/storage/storage-classes/) for official docs of Storage Classes
- `kubectl get sc` to get the available storage classes
-   Access Modes
    -   RWO – ReadWriteOnce (Suitable for block storages like EBS, Azure Disk, Persistent Disk)
    -   ROX – ReadOnlyMany (Any disk)
    -   RWX – ReadWriteMany (Typically fileshares or blob storages)
    -   RWOP – ReadWriteOncePod (Suitable for block storages like EBS, Azure Disk, Persistent Disk)
-   [Refer Here](https://learn.microsoft.com/en-us/azure/aks/azure-csi-disk-storage-provision) for using Azure Disk as PV

### Lets create a mysql Pod where we create a persitent volume dynamically

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: mysql
  labels:
    name: mysql
spec:
  containers:
    - name: mysql
      image: mysql:9
      # skipped env, ports, resorces columns
      volumeMounts:
        - name: libdb
          mountPath: /var/lib/mysql
  volumes:
    - name: libdb
      persistentVolumeClaim:
        claimName: mysql-pvc
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: mysql-pvc
spec:
  accessModes:
    - ReadWriteOnce
  storageClassName: managed
  resources:
    requests:
      storage: 1Gi
```
-   Exercise: Try running mongodb with pvc and postgres with pvc

---
---

### <mark>**Necessity for database cluster**</mark>

-   To have **High Availability** we run database in multiple servers in the case of k8s multiple pods
-   IN db cluster we have multiple servers and each server will have its own storage
-   So we need to create pods and each pod should have its own persistent volume
-   challenge to create cluster with deployments:
    -   managing multiple PVs
    -   pod names are not predictable: database clusters generally will have predictable endpoints (read endpoint, write endpoint)
-   So we need a way to create
    -   multiple pods and pvs
    -   pod names should be predicatable
-   all of the above are acheived with stateful sets

---

## <mark>**Statefulset**</mark>
-   [Refer Here](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/) for official docs
-   Stateful sets create multiple pods with a predicatable name in a sequential order (0 to n)
-   Rolling updates will be performed in a reverse order (n-0)
-   Each Pod will raise a PVC to get a PV [refer **Kubernetes Storage** for pvc]
-   Generally we will have a headless service to access specific pod
-   Statefulsets are widely used to create database clusters and any application with state.
-   Since we acces pod using headless service the libarary application will have a DATABASE URI changed to \
    `postgresql://user:password@<pod-name>.<service-name>:5432/<postgres-db>`
-   [Refer Here](https://github.com/mydummyrepo/library_application/blob/main/users_db.yml) for the changes done to move away from replicaset to stateful set for database pods in library application.
-   For executions watch classroom recording

___
---
## <mark>**Lens**</mark>

-   [Refer Here](https://k8slens.dev/) for kubernetes lens IDE
  
---
---
## <mark>**Scheduling pods on Specific Nodes**</mark>

[Refer here for Official docs](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/) on Assigning Pods to Specific Nodes

* In Kubernetes, scheduling pods on nodes is essential to ensure resources are utilized efficiently and application requirements are met.
* Here are key techniques and strategies used for scheduling pods:

### 1. **Node Selector**

- The simplest method to control pod scheduling to specific nodes.
- Define **`nodeSelector`** in the pod specification to match required node labels.
- Only nodes with the specified labels will be eligible to host the pod.

```yaml
spec:
  nodeSelector:
    disktype: ssd
``` 

This ensures the pod is scheduled only on nodes labeled with `disktype: ssd`.
---
### 2. **Affinity and anti-affinity**

#### **Node affinity and Anti-Affinity**
-   **Node Affinity**: A more flexible and expressive method than `nodeSelector`. Allows specifying rules for preferred and required node selection.
    -   _Required (hard constraint)_: The pod will only be scheduled if nodes match.
    -   _Preferred (soft constraint)_: The scheduler tries to match but may skip if unavailable.
-   **Anti-Affinity**: Ensures that certain pods are not placed on the same node or close to others. Useful for high availability.

```yaml
spec:
  affinity:
    nodeAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
        nodeSelectorTerms:
          - matchExpressions:
              - key: disktype
                operator: In
                values:
                  - ssd
```
#### **Pod Affinity and Anti-Affinity**

- **Pod Affinity**: Ensures pods are scheduled together on nodes for better performance or resource sharing.
- **Pod Anti-Affinity**: Spreads pods across nodes to prevent resource contention or failure impact.

```yaml
affinity:
  podAffinity:
    requiredDuringSchedulingIgnoredDuringExecution:
      - labelSelector:
          matchLabels:
            app: frontend
        topologyKey: "kubernetes.io/hostname"
```
* Common Topology Keys:
  * Some commonly used topology keys include:
  * <u>topology.kubernetes.io/zone</u>: This key represents different availability zones within a cloud provider. Pods can be scheduled to ensure they are in the same zone or spread across different zones.
  * <u>kubernetes.io/hostname</u>: This key refers to individual node names. It can be used to ensure that certain pods are co-located on the same node or, conversely, not placed on the same node.
---

### 3. **Taints and Tolerations**

- **Taints**: Repel certain pods by applying constraints on nodes.
- **Tolerations**: Allow pods to tolerate taints, enabling scheduling on tainted nodes.
- Commonly used for dedicated or isolated workloads.

#### Example of Adding Taints

To add a taint to a node, you can use the following command:

```bash
kubectl taint nodes <node-name> key=value:NoSchedule
```
#### Example of Adding Tolerations

```yaml
tolerations:
  - key: "key"
    operator: "Equal"
    value: "value"
    effect: "NoSchedule"
```
#### Built-in Taints

Kubernetes includes several built-in taints that manage node conditions automatically:

- `node.kubernetes.io/not-ready`: Applied when the node is not in a ready state.
- `node.kubernetes.io/unreachable`: Applied when the node is unreachable from the controller.
- `node.kubernetes.io/memory-pressure`: Indicates that the node is experiencing memory pressure.
- `node.kubernetes.io/disk-pressure`: Indicates disk pressure on the node.
---

### 4. **Resource Requests and Limits**

- Define CPU and memory needs for pods to prevent overloading nodes.
- Requests ensure minimal resource availability.
- Limits cap resource usage per pod.

```yaml
resources:
  requests:
    memory: "64Mi"
    cpu: "250m"
  limits:
    memory: "128Mi"
    cpu: "500m"
```

---

### 5. **Priority and Preemption**

- Prioritize critical applications by allowing higher-priority pods to preempt lower-priority ones.
- Managed using **priority classes**, ensuring essential apps are scheduled under resource constraints.

```yaml
# Define a PriorityClass
apiVersion: scheduling.k8s.io/v1
kind: PriorityClass
metadata:
  name: high-priority
value: 1000000 # higher number higher value
globalDefault: false
description: "This priority class is for critical applications."
---
# Deployment using the high-priority class

    spec:
      priorityClassName: high-priority  # Use the defined priority class
      containers:
        - name: app-container
          image: your-image:latest
          ports:
            - containerPort: 80
```
---

### 6. **Topology Spread Constraints**

- Distribute pods evenly across nodes to reduce single points of failure.
- Ensures fault tolerance and optimal use of availability zones.

```yaml
# This example shows how to distribute pods evenly across availability zones using topology spread constraints.
topologySpreadConstraints:
  - maxSkew: 1  # Allow at most one pod difference between zones.
    topologyKey: "topology.kubernetes.io/zone"  # Spread across zones.
    whenUnsatisfiable: DoNotSchedule  # Don't schedule if constraints can't be met.
    labelSelector:
      matchLabels:
        app: frontend  # Match the frontend application pods.
```

---

### 7. **Custom Schedulers**

- Use custom Kubernetes schedulers for specific workload requirements (e.g., data locality or latency optimization).

---
---
### <mark>**Cordon and Drain in Kubernetes**</mark>

**Cordon** and **Drain** are administrative commands for managing node workloads during maintenance, upgrades, or decommissioning.

---

### **Cordon**

- **Purpose**: Prevents new pods from being scheduled on a node while keeping existing pods running.
- Marks the node as **unschedulable** without disrupting workloads.

**Command**:  
```bash
kubectl cordon <node-name>
```
---

### **Drain**

- **Purpose**: Safely evicts all pods from a node.
- Ensures workloads are shifted to other nodes if resources are available.
- Respects **PodDisruptionBudgets** to avoid disrupting critical services.
- Does not affect DaemonSet pods (they are skipped).

**Command**:  
```bash
kubectl drain <node-name> --ignore-daemonsets --delete-emptydir-data
```

**Flags**:
- `--ignore-daemonsets`: Ignores DaemonSet-managed pods during eviction.
- `--delete-emptydir-data`: Deletes pods using ephemeral `emptyDir` volumes.

---

### **Workflow: Cordon and Drain**

1. **Cordon** the node to stop new pods from being scheduled:
   ```bash
   kubectl cordon <node-name>
   ```
2. **Drain** the node to evict running pods safely:
   ```bash
   kubectl drain <node-name> --ignore-daemonsets --delete-emptydir-data
   ```
3. Perform necessary maintenance or upgrades.
4. **Uncordon** the node to make it schedulable again:
   ```bash
   kubectl uncordon <node-name>
   ```

---
---

## <mark>**Administrative Activity: Upgrading K8s Clusters**</mark>

### **Self-Hosted Clusters**

1. Review release notes for new version changes.
2. Backup etcd cluster and persistent volumes.
3. **Cordon** the node to prevent scheduling.
4. **Drain** the node to evict pods safely.
5. Upgrade using Linux commands.
6. **Uncordon** the node to resume scheduling.


### **Managed Clusters**

- Follow cloud provider documentation for upgrades.

---
---
## <mark>**Ingress and Ingress Controllers**</mark>

- Official Docs: [Ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/) | [Ingress Controllers](https://kubernetes.io/docs/concepts/services-networking/ingress-controllers/)

#### **Ingress**

- **Purpose**: Manages HTTP(S) traffic into the cluster, acting as an entry point to expose services. It supports routing, TLS termination, and advanced traffic rules beyond traditional **NodePort** or **LoadBalancer** services.

<img src="images/img_29.png" alt="Ingress_path_Routing" width="400" />

**Key Features**:
1. **Path-based Routing**: Directs traffic to services based on URL paths.  
2. **Host-based Routing**: Routes traffic based on domain names.  
3. **TLS Termination**: Simplifies HTTPS communication by offloading encryption.  
4. **Backend Services**: Connects to and distributes traffic among services.  


#### **Ingress Controllers**

- **Purpose**: Implements the Ingress resource, routing traffic based on its rules. Kubernetes does not include a default Ingress Controller—you need to deploy one.  

To install the NGINX Ingress Controller in your Kubernetes cluster, you can use the following command:

```bash
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/cloud/deploy.yaml
```

**Common Controllers**:  
1. **NGINX** (most widely used)  
2. **Traefik**  
3. **HAProxy**  
4. **AWS ALB Ingress** (for AWS-specific workloads)  
5. **Istio Gateway** (part of Istio service mesh)  


#### **Annotations for Custom Behavior**

**Examples**:
- **Rewrite URLs**:  
  ```yaml
  nginx.ingress.kubernetes.io/rewrite-target: /
  ```
- **Enforce HTTPS**:  
  ```yaml
  nginx.ingress.kubernetes.io/force-ssl-redirect: "true"
  ```
- **Set Load Balancer Limits**:  
  ```yaml
  nginx.ingress.kubernetes.io/proxy-body-size: 10m
  ```
---
To get the ingress class
```bash
kubectl get ingressclasses
```
**Example file**:
```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: app-ingress
spec:
  ingressClassName: nginx     # ingress class
  rules:
    - http:
        paths:
          - path: /app1
            pathType: Prefix
            backend:
              service:
                name: app1-service
                port:
                  number: 80
          - path: /app2
            pathType: Prefix
            backend:
              service:
                name: app2-service
                port:
                  number: 80
```
---
---

## <mark>Kubernetes Metrics Service</mark>

* The **Kubernetes Metrics Server** is a key component that collects and aggregates resource metrics (CPU and memory) from nodes and pods in a Kubernetes cluster.
* It primarily supports the Horizontal Pod Autoscaler (HPA) and Vertical Pod Autoscaler (VPA).
* [Refer Here](https://kubernetes-sigs.github.io/metrics-server/) for metrics-server docs.

### Key Features
- **Resource Metrics Collection**: Gathers metrics from Kubelets and exposes them via the Metrics API.
- **Autoscaling Support**: Provides metrics for HPA and VPA, enabling dynamic scaling of workloads.
- **Lightweight**: Consumes minimal resources, making it efficient for large clusters.
- **Easy Deployment**: Can be deployed simply as a single instance in most clusters.

### Use Cases
- **Horizontal Autoscaling**: Adjusts pod replicas based on CPU/memory usage.
- **Vertical Autoscaling**: Suggests optimal resource requests for containers.
- **Monitoring**: Allows users to retrieve metrics using `kubectl top`.

### Limitations
- **Not Comprehensive**: Does not serve as a general-purpose monitoring solution due to Limited Resource Tracking.
  - integration with tools like Prometheus is recommended for detailed monitoring.

### Implementation
To deploy:
1. Install using `kubectl` or Helm:
   ```bash
   kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
   ```
2. Verify deployment with:
   ```bash
   kubectl get pods --all-namespaces | grep metrics-server
   ```
3. Access metrics via the Kubernetes API or `kubectl top` \
   **`kubectl top pods`**

#### **Note**
- To enable monitoring for **managed clusters**, we have to follow cloud-specific approaches.
---

### Horizontal Pod Autoscaler

- Automatically adjusts the number of pod replicas in a Kubernetes deployment based on observed CPU, memory, or custom metrics.
- **[Refer Here](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/)** for Horizontal Pod Autoscaler documentation.

```yaml
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: hpa-demo
spec:
  maxReplicas: 10
  minReplicas: 1
  scaleTargetRef:
    apiVersion: apps/v1   # Specify the API version of the target resource
    kind: Deployment       # Specify the kind of resource being targeted (e.g., Deployment, StatefulSet)
    name: web-app         # Name of the deployment to scale
  behavior:               # Default 
    scaleUp:
      stabilizationWindowSeconds: 60
      policies:
        - type: Pods       # Type of scaling policy (Pods or Percent)
          value: 1        # Number of pods to add per scaling event
          periodSeconds: 60
    scaleDown:
      stabilizationWindowSeconds: 60
      policies:
        - type: Percent    # Type of scaling policy (Pods or Percent)
          value: 10       # Percentage of pods to remove per scaling event
          periodSeconds: 60
  metrics:
    - resource:
        name: cpu         # Resource metric to monitor (cpu, memory)
        target:
          type: Utilization
          averageUtilization: 70   # Target average CPU utilization percentage

```
### Vertical Pod Autoscaler

- Automatically adjusts the resource requests and limits for containers in a pod based on historical usage data to ensure optimal resource allocation.
- **VPA** can operate in different **modes** (Off Mode, Initial Mode, Auto mode, Recreate Mode), with the **Off mode** being primarily used for providing **resource recommendations** without automatically applying them.
- **[Refer Here](https://kubernetes.io/docs/concepts/workloads/autoscaling/)** for official documentation on Vertical Pod Autoscaler.

```yaml
apiVersion: autoscaling.k8s.io/v1
kind: VerticalPodAutoscaler
metadata:
  name: vpa-demo
spec:
  targetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: web-app
  updatePolicy:
    updateMode: "Off"  # Set to Off to only gather recommendations
  resourcePolicy:
    containerPolicies:
      - containerName: "web-app-container"
        minAllowed:
          cpu: "100m"       # Minimum CPU allocation
          memory: "128Mi"   # Minimum memory allocation
        maxAllowed:
          cpu: "1"          # Maximum CPU allocation
          memory: "1Gi"     # Maximum memory allocation

```
### Node Autoscaling (for Managed K8s Clusters)

- Node autoscaling in Kubernetes refers to the automatic adjustment of the number of nodes in a cluster based on the demands of workloads.
- **[Refer Here](https://kubernetes.io/docs/concepts/cluster-administration/cluster-autoscaling/)** for official documentation

---
---
## <mark>**Network Policy**</mark>

- **[Refer Here](https://kubernetes.io/docs/concepts/services-networking/network-policies/)** for Network Policy documentation.
  
### Overview of Network Policies

* Network Policies control traffic flow at the IP address or port level (OSI layer 3 or 4). 
* They specify rules for traffic flow within your cluster and between Pods and the outside world.
* Ensure your cluster uses a network plugin that supports NetworkPolicy enforcement.

### Example Network Policy YAML

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: users-db-np
spec:
  podSelector:
    matchLabels:
      db: users
  policyTypes:
    - Ingress
  ingress:
    - from:
        - podSelector:
            matchLabels:
              app: users
```
**Example NetworkPolicy to Deny All Traffic from Other Namespaces**

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: deny-from-other-namespaces
  namespace: default  # Specify the namespace where this policy applies
spec:
  podSelector: {}  # Select all pods in the specified namespace
  policyTypes:
    - Ingress  # This policy applies to incoming traffic
  ingress:
    - from:
        - podSelector: {}  # Allow traffic from all pods in the same namespace

```
**Labels for Network policy (podSelector)**

<img src='images\img_34.png' alt='library_app_labels' width='400'>

---
---

## <mark>**Kubernetes Authentication and Authorization**</mark>

<mark>**The kubeconfig file contains**:</mark>

* clusters information: Foreach cluster we have **url of apiServer** and **cluster certificate** (for tls auth)
* One **.kube config file** can have **multiple clusters**
* For Each Cluster there will be certificate and url

**Kube Config File Certificates and Keys**

1. **Server Certificate and Key**:
   - **Purpose**: Used by the Kubernetes API server to establish secure TLS connections with clients.
   - **Location**: Typically stored in `/etc/kubernetes/pki`.

2. **Client Certificate and Key**:
   - **Purpose**: Used by clients (like `kubectl`) to authenticate themselves to the Kubernetes API server.
   - **Location**: Paths specified in the `kubeconfig` file, e.g., `--client-certificate` and `--client-key`.


<img src="images/img_30.png" alt="Diagram" width="500" />

* context: which cluster and which namespace is default
* we can switch context
  * For more detailed information and examples, you can refer to the following official documentation:
    - [Kubernetes Documentation on Configuring Access to Multiple Clusters](https://kubernetes.io/docs/tasks/access-application-cluster/configure-access-multiple-clusters/)
    - [Kubectl Config Set-Context Command](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_config/kubectl_config_set-context/)
    - [Spacelift Blog on Kubectl Config Set-Context](https://spacelift.io/blog/kubectl-set-context)
  
<img src="images/img_31.png" alt="Diagram" width="500" />

**users**:

##### User Certificate and Key
1. **User Certificate and Key**:
   - **Purpose**: Used by individual users to authenticate themselves to the Kubernetes cluster.
   - **Location**: Paths specified in the `kubeconfig` file under the user entry.
   - **Purpose**: Used by the Kubernetes API server to establish secure TLS connections with clients.
   - **Location**: Typically stored in `/etc/kubernetes/pki`.

<img src="images/img_32.png" alt="Diagram" width="500" />

---
### <mark>**Overview of Authentication and Authorization**</mark>

**Overview**

<img src="images/img_33.png" alt="Diagram" width="500" />

```
**Checking User Identity (Authentication)** --> **Permission to Activity (Authorization)** --> **Validate Activity Against Kubernetes Policies (Admission Control)**  --> **Store State in etcd (Persistence)**
```

### <mark>**Authentication**</mark>

- Kubernetes does not have an inbuilt identity system; authentication is pluggable.
- External identity providers include:
  - Azure AD
  - AWS IAM
  - OIDC
  - Active Directory (AD)

### <mark>**Authorization**</mark>

- Authorization is also pluggable, with RBAC (Role-Based Access Control) being the most widely adopted method.
    -   Role:
        -   You define the permission at **namespace level**
    -   RoleBinding
        -   Attaching a Role to a user/serviceaccount
    -   ClusterRole:
        -   You define the permission at **cluster level**
    -   ClusterRoleBinding
        -   Attaching a clusterrole to a user/serviceaccount

#### 1. <u>**User-Role Definitions**</u>:

- **Role**: Defines permission levels at the namespace level.
  
```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  namespace: default # Specify the namespace
  name: readonly
rules:
  - apiGroups: ["*"]  # a way to group related API objects together in k8s
    resources: ["*"]
    verbs: ["get", "list", "watch"]
```

- **RoleBinding**: Attaches a Role to a user/service account.

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: readonly-user-binding
  namespace: default # Specify the namespace
subjects:
  - kind: User # or Group if using groups
    name: user1aksadmin@yourdomain.com # The user's email
    apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: Role
  name: readonly
  apiGroup: rbac.authorization.k8s.io
```

#### 2. <u>**Service Accounts**</u>
* Users are not part of k8s, but service accounts are 
*  Every Pod is assigned a Service Account unless specified otherwise(which is a security risk). \
  `automountServiceAccountToken: false`

**Purpose**: 
- To provide an identity for processes running in Pods to interact with the Kubernetes API.
- To manage access control and permissions for those processes.

**Types of Service Accounts**:
1. **Default Service Account**: Automatically created in every namespace and used if no other service account is specified.
2. **Custom Service Accounts**: Created by users to grant specific permissions.

### Creating and Using Service Accounts

1. **Create a Service Account**:
   ```yaml
   apiVersion: v1
   kind: ServiceAccount
   metadata:
     name: my-service-account
     namespace: default
   ```
   - Save this YAML to a file (e.g., `service-account.yaml`) and apply it:
     ```bash
     kubectl apply -f service-account.yaml
     ```

2. **Assign Service Account to a Pod**:
   ```yaml
   apiVersion: v1
   kind: Pod
   metadata:
     name: my-pod
   spec:
     serviceAccountName: my-service-account
     containers:
     - name: my-container
       image: my-image
   ```
   - Save this YAML to a file (e.g., `pod-with-service-account.yaml`) and apply it:
     ```bash
     kubectl apply -f pod-with-service-account.yaml
     ```

### Managing Permissions with Role-Based Access Control (RBAC)

1. **Create a Role**:
   ```yaml
   apiVersion: rbac.authorization.k8s.io/v1
   kind: Role
   metadata:
     namespace: default
     name: pod-reader
   rules:
   - apiGroups: [""]
     resources: ["pods"]
     verbs: ["get", "list", "watch"]
   ```

2. **Bind the Role to a Service Account**:
   ```yaml
   apiVersion: rbac.authorization.k8s.io/v1
   kind: RoleBinding
   metadata:
     name: read-pods
     namespace: default
   subjects:
   - kind: ServiceAccount
     name: my-service-account
     namespace: default
   roleRef:
     kind: Role
     name: pod-reader
     apiGroup: rbac.authorization.k8s.io
   ```
   - Save these YAMLs and apply them using:
     ```bash
     kubectl apply -f role.yaml
     kubectl apply -f rolebinding.yaml
     ```

### <mark>**Admission Control**</mark>

#### Mutation-Based Admission Control
- **Purpose**: Mutate or alter the requests before they are persisted.
- **Examples**: Add default values, inject sidecars, modify resource requests.

#### Validation-Based Admission Control
- **Purpose**: Validate the requests to ensure they comply with policies.
- **Examples**: Enforce resource quotas, pod security policies, deny specific configurations.
---

#### **`kubectl auth can-i` command:**

The `kubectl auth can-i` command is a helpful tool to check whether a user or service account has permission to perform a specific action in your Kubernetes cluster. Here's how you can use it:

### Usage

To check if you have permission to perform an action:
```bash
kubectl auth can-i <verb> <resource>
```

For example,

1. **Check if you can create deployments**:
   ```bash
   kubectl auth can-i create deployments
   ```

---

### <mark>Custom Resource Definitions (CRDs) & Operators in Kubernetes</mark>

#### Custom Resource Definitions (CRDs)

* **Custom Resource Definitions (CRDs)** allow users to define their own types of resources in Kubernetes, similar to built-in resources like Pods and Services.
* These custom resources can help you extend Kubernetes' functionality by adding new types of resources specific to your application or domain.


**Key Features**:
- **Extend Kubernetes API**: CRDs enable you to define your own API resources.
- **Declarative Configuration**: Manage new types of resources in a declarative manner, similar to built-in resources like Pods and Deployments.

Example CRD:
```yaml
apiVersion: apiextensions.k8s.io/v1
kind: CustomResourceDefinition
metadata:
  name: myresources.example.com
spec:
  group: example.com
  versions:
    - name: v1
      served: true
      storage: true
      schema:
        openAPIV3Schema:
          type: object
          properties:
            spec:
              type: object
              properties:
                field1:
                  type: string
                field2:
                  type: integer
  scope: Namespaced
  names:
    plural: myresources
    singular: myresource
    kind: MyResource
    shortNames:
    - mr

```
* **Kubectl Support**: Once a CRD is defined, you can use `kubectl` to manage custom resources just like any other Kubernetes resource.

#### **Operators**
* Operators in Kubernetes are tools that help automate the management of applications.
* They use Custom Resource Definitions (CRDs) to extend Kubernetes' capabilities, allowing you to package, deploy, and manage complex applications consistently and automatically.
* They create **reconcile loop** (ensures that the actual state of the cluster matches the desired state)
*   Lifecycle => CRD + Operator


---
---

## <mark>**Managing Kubernetes Manifests and Configurations**</mark>

### <u>**Problem with Kubernetes Manifests**</u>

#### Problem 1: **Static YAML Manifests**

-   K8s manifests are static in nature
-   During deployments we will have changes to handle
    -   image tags
    -   labels
    -   namespaces
-   We have to manually change the manifests

#### Problem 2: **No Reusability**

-   Manifest YAML files are not reusable

### <u>**Solution**</u>

1.  Helm:
  * This works as a package manager to kubernetes
  * we need to install helm
2.  Kustomize:
  * This works as if manages multiple environments
  * This works with native kubectl
---


## Helm

- **[Refer Here](https://helm.sh/)** for official docs and **[Refer Here](https://helm.sh/docs/intro/install/)** to install Helm.
- **In Helm:**

    ![Preview](images\img_35.png)

- **Components:**
    - Helm (client)
    - Repository (Which hosts the charts)
    - Chart (An individual package)

---

## Create a Helm Chart for Basic Deployment

- **Sample Static YAML Manifest:**

```yaml
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:1.27
        resources:
          limits:
            memory: "128Mi"
            cpu: "500m"
        ports:
        - containerPort: 80
---
apiVersion: v1
kind: Service
metadata:
  name: nginx-svc
spec:
  type: ClusterIP
  selector:
    app: nginx
  ports:
  - port: 80
    targetPort: 80
```

---
### **Helm Charts**

### activity1: helm chart creation

- **Let's create a Helm chart:**

```bash
helm create activity1
```
* A **folder** called as activity1 is create with following content


```
# Structure of Helm Charts
my-chart/
  Chart.yaml            # A YAML file containing information about the chart
  LICENSE               # OPTIONAL: A plain text file containing the license for the chart
  README.md             # OPTIONAL: A human-readable README file
  values.yaml           # The default configuration values for this chart
  values.schema.json    # OPTIONAL: A JSON Schema for imposing a structure on the values.yaml file
  charts/               # A directory containing any charts upon which this chart depends.
  crds/                 # Custom Resource Definitions
  templates/            # A directory of templates that, when combined with values,
                        # will generate valid Kubernetes manifest files.
    templates/NOTES.txt # OPTIONAL: A plain text file containing short usage notes
```
```
# Example of Chart structure
my-chart/
├── Chart.yaml
├── values.yaml
├── templates/
│   ├── deployment.yaml
│   └── service.yaml
└── charts/
```
---


* [Refer here](https://helm.sh/docs/topics/charts/) for official docs on Charts.


### Installing a Helm Chart

To install a Helm chart, you can use the following command:

```bash
helm install <release-name> <chart-name> --values <release-name>/values.yaml
# Using --values to pass file with Custom Values
```

* Helm use go templating syntax [Refer here](https://helm.sh/docs/chart_template_guide/)
* **Use <mark>helm online validator</mark> to verify expression** [Refer Here](https://helm-playground.com/)
* Helm creates manifests and passes it to the kubectl after \
  replacing dynamic expression (template expressions)

<img src='images\img_37.png' alt='helm validator' width='1000'>

* [Refer Here](https://helm-playground.com/cheatsheet.html) for synaxes used in Helm.
* [Example]()
* Now create a chart repository and push the chart to repository

---
---

## <mark>Using **variables** within Helm templates.</mark>

* Each line demonstrates different functions and methods for handling values from the `values.yaml` file in a Helm chart.

### 1. Basic Value Reference

- **`name: {{ .Values.storageClassName }}`**
  - This simply retrieves the value of `storageClassName` from the `values.yaml` file. If `storageClassName` is defined, it will be used directly.

### 2. Quoting Values

- **`name: {{ .Values.storageClassName | quote }}`**
  - This retrieves the value of `storageClassName` and wraps it in quotes. This is useful for ensuring that the value is treated as a string, especially if it contains special characters or spaces.

### 3. Default Values

- **`name: {{ .Values.storageClassName | default "default value" }}`**
  - This retrieves `storageClassName`, but if it is not set (i.e., it is `nil`), it will use `"default value"` instead. This provides a fallback option.

### 4. Required Values

- **`name: {{ .Values.storageClassName | required ".storageClassName must be set" }}`**
  - This checks if `storageClassName` is set. If it is not, it will return an error with the specified message, preventing the chart from being installed without this critical value.

### 5. Trimming Whitespace

- **`name: {{ .Values.storageClassName | trim }}`**
  - This removes any leading or trailing whitespace from the value of `storageClassName`.

### 6. Formatted Strings

- **`name: {{ printf "%s-%d" .Values.storageClassName .Values.storageClassVersion }}`**
  - This uses the `printf` function to format a string that combines `storageClassName` and `storageClassVersion`. For example, if `storageClassName` is "fast" and `storageClassVersion` is "1", it would produce "fast-1".
	- %d ==> for integer, %s ==> for string

### 7. Replacing Placeholders

- **`name: {{ .Values.storageClassName | replace "{placeholder}" "example" }}`**	
  - This replaces occurrences of `{placeholder}` in `storageClassName` with "example". This can be useful for dynamic configurations.

### 8. Variable Assignment

- **`{{ $fullName := printf "%s %s" .Values.firstName .Values.lastName }}`**
  - This assigns a formatted string (combining first and last names) to a variable named `$fullName`, which can be used later in the template.

### 9. Trimming Specific Characters

- **`name: {{ .Values.storageClassName | trimAll "/" }}`**
  - This removes all occurrences of the character `/` from both ends of the `storageClassName`.

- **`name: {{ .Values.storageClassName | trimPrefix "/" }}`**
  - This removes a leading `/`, if present, from the beginning of `storageClassName`.

- **`name: {{ .Values.storageClassName | trimSuffix "/" }}`**
  - This removes a trailing `/`, if present, from the end of `storageClassName`.

### 10. Changing Case

- **`name: {{ .Values.storageClassName | lower }}`**
  - Converts the value of `storageClassName` to lowercase.

- **`name: {{ .Values.storageClassName | upper }}`**
  - Converts the value of `storageClassName` to uppercase.

---

## <mark>**Built-in's**</mark>

The built-in expressions you provided are part of Helm's templating capabilities, allowing you to access various contextual information about the release, chart, and files. Here’s a detailed explanation of each expression:

### 1. Release Information

- **`{{ .Release.Name }}`**:
  - This expression retrieves the name of the current Helm release. The release name is specified when you install or upgrade a chart and is used to identify that specific deployment within the Kubernetes cluster.

- **`{{ .Release.Namespace }}`**:
  - This expression fetches the namespace in which the Helm release is deployed. If no namespace is specified during installation, it defaults to the `default` namespace.

### 2. Chart Information

- **`{{ .Chart.Name }}`**:
  - This retrieves the name of the chart being deployed. The chart name is defined in the `Chart.yaml` file and represents the application or service being packaged.

- **`{{ .Chart.Version }}`**:
  - This expression gets the version of the chart being used. This version is also specified in the `Chart.yaml` file, which helps track which version of an application is deployed.

### 3. File Access

- **`{{ .Files.Get "config.ini" }}`**:
  - This expression retrieves the contents of a file named `config.ini` located in the `files/` directory of your Helm chart. The `.Files.Get` function allows you to include external configuration files directly into your templates, making it easier to manage complex configurations.

---
## <mark>**Conditionals**</mark>
```go
{{ if .Values.enablePersistence }}
  # ...
{{ else if .Values.enableFilesystem }}
  # ...
{{ else }}
  # ...
{{ end }}

# equal, not equal
{{ if eq .Values.environment "production" }}
{{ if ne .Values.environment "production" }}

# and, or
{{ if and (eq .Values.environment "production") (eq .Values.host "minikube") }}
{{ if or (eq .Values.environment "production") (eq .Values.host "minikube") }}

# not (negation)
{{ if not (eq .Values.environment "production") }}

# greater than, less than
{{ if gt (len .Values.items) 3 }}
{{ if gte (len .Values.items) 3 }}
{{ if lt (len .Values.items) 3 }}
{{ if lte (len .Values.items) 3 }}

# strings
{{ if .Values.name | contains "example" }}
{{ if .Values.name | hasPrefix "foobar-" }}
{{ if .Values.name | hasSuffix "-foobar" }}
{{ if .Values.name | regexMatch "^[a-z]+$" }}

# lists
{{ if .Values.items | has "example" }}

# ternary
{{ ternary "returned if true" "returned if false" .Values.someBoolean }}
```
---
## <mark>**Loops**</mark>

loops are used to iterate over collections such as lists (arrays) and maps (dictionaries).

### 1. Simple Loop

```yaml
volumes:
  {{ range .Values.volumeIds }}
  - volumeName: {{ . }}
  {{ end }}
```

- **Explanation**:
  - **`{{ range .Values.volumeIds }}`**: This starts a loop over the `volumeIds` array defined in your `values.yaml` file.
  - **`.`**: Inside the loop, `.` refers to the current item in the iteration. In this case, it represents each individual volume ID.
  - **`{{ end }}`**: This ends the loop.
  
- **Usage**: This is useful for generating a list of items based on an array of values. For example, if `volumeIds` contains multiple volume IDs, this loop will create a corresponding list of volumes in the output YAML.

### 2. Loop with Named Variable

```yaml
volumes:
  {{ range $volumeId := .Values.volumeIds }}
  - volumeName: {{ $volumeId }}
  {{ end }}
```

- **Explanation**:
  - **`{{ range $volumeId := .Values.volumeIds }}`**: This starts a loop similar to the previous example but uses a named variable `$volumeId` to refer to the current item in the iteration.
  - **`{{ $volumeId }}`**: This explicitly references the named variable instead of using `.`.
  
- **Usage**: This approach is beneficial when you want to make your code more readable or when you need to use the variable multiple times within the loop.

### 3. Loop with Index (Array) or Key (Dict)

```yaml
volumes:
  {{ range $key, $value := .Values.configuration }}
  - {{ $key }}: {{ $value }}
  {{ end }}
```

- **Explanation**:
  - **`{{ range $key, $value := .Values.configuration }}`**: This starts a loop over a map (dictionary) called `configuration`. Here, `$key` represents each key in the map, and `$value` represents the corresponding value.
  - **`{{ $key }}` and `{{ $value }}`**: These are used to output the key-value pairs from the map.
  
- **Usage**: This is useful for generating key-value pairs in your YAML output when working with dictionaries. For example, if `configuration` contains settings for your application, this loop will create entries for each configuration setting.

### Example Values File

To illustrate how these loops work, here’s an example `values.yaml` file that could be used with the above templates:

```yaml
volumeIds:
  - volume1
  - volume2
  - volume3

configuration:
  setting1: value1
  setting2: value2
```

### Example Rendered Output

Using the above values file with your loops would yield:

```yaml
volumes:
  - volumeName: volume1
  - volumeName: volume2
  - volumeName: volume3

# For configuration output
setting1: value1
setting2: value2
```
---

## <mark>**Indentation**</mark>

### 1. Using `toYaml` with `indent`

```yaml
env:
  {{ .Values.environmentVariables | toYaml | indent 2 }}
```

- **`toYaml`**: This function converts a given data structure (like a map or list) into a YAML-formatted string. However, it does not automatically adjust the indentation of the output relative to its context.
- **`indent 2`**: This function adds two spaces of indentation to each line of the output from `toYaml`. This is useful when you want to ensure that the generated YAML is properly nested under the `env:` key.

**Output Example**:
If `environmentVariables` contains:
```yaml
environmentVariables:
  VAR1: value1
  VAR2: value2
```

The rendered output will be:
```yaml
env:
    VAR1: value1
    VAR2: value2
```

### 2. Using `toYaml` with `nindent`

```yaml
env: {{ .Values.environmentVariables | toYaml | nindent 2 }}
```

- **`nindent 2`**: Similar to `indent`, but it also ensures that the first line of the output starts on a new line. This is particularly useful when you want to avoid any potential issues with inline content or when the preceding line ends with content.

**Output Example**:
Using the same `environmentVariables`, the rendered output will be:
```yaml
env:
  VAR1: value1
  VAR2: value2
```
---


---
## <mark>**Includes**</mark>

[Refer Here](https://helm-playground.com/cheatsheet.html) for syntax.

Let's assume some example values in the `values.yaml` file and demonstrate how the templates would work with the given definitions.

---

### **Example `values.yaml`**
```yaml
image:
  name: my-app
  tag: v1.2.3

foobar: "This is a {placeholder} string."
```

---

### **Templates**
1. **`your-project.image`**
   ```yaml
   {{- define "your-project.image" -}}
   {{ printf "%s:%s" .Values.image.name .Values.image.tag | quote }}
   {{- end -}}
   ```

2. **`your-project.someInclude`**
   ```yaml
   {{- define "your-project.someInclude" -}}
   {{ . | replace "{placeholder}" "example" }}
   {{- end -}}
   ```

---

### **Rendered YAML Output**

1. **For `image` Field**  
   If you use the following in your deployment file:

   ```yaml
   image: {{ include "your-project.image" . }}
   ```

   With the given `values.yaml`, the output will be:

   ```yaml
   image: "my-app:v1.2.3"
   ```

2. **For `foobar` Field**  
   If you use the following in your deployment file:

   ```yaml
   foobar: {{ include "your-project.someInclude" .Values.foobar }}
   ```

   With the given `values.yaml`, the output will be:

   ```yaml
   foobar: "This is a example string."
   ```

---

### **Full Rendered Output Example**

Combining both templates in a deployment file:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: example-deployment
spec:
  template:
    spec:
      containers:
        - name: example-container
          image: {{ include "your-project.image" . }}
          env:
            - name: EXAMPLE_FOOBAR
              value: {{ include "your-project.someInclude" .Values.foobar }}
```

After rendering with Helm, the output would look like this:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: example-deployment
spec:
  template:
    spec:
      containers:
        - name: example-container
          image: "my-app:v1.2.3"
          env:
            - name: EXAMPLE_FOOBAR
              value: "This is a example string."
```

This showcases how reusable templates can simplify and streamline your Helm charts.

You're absolutely correct that you **could directly write** something like this:

```yaml
image: {{ printf "%s:%s" .Values.image.name .Values.image.tag | quote }}
```

This is valid and would work perfectly. However, there are **several reasons** why defining reusable templates (like in `_helpers.tpl`) is often a better approach in Helm charts:


### **Summary**
- Use reusable templates when logic is complex or shared across multiple places for better **maintainability**, **readability**, and **consistency**.
- Use inline expressions for **one-off, simple cases**.

If you're creating production-grade Helm charts or working in a team, reusable templates in `_helpers.tpl` are generally the better choice.

---

Let me break this down more simply. This code decides **where the value of `foobarPassword` should come from** for a Kubernetes Secret. There are **three possible options** in order of priority:

---
## <mark>**Lookup**</mark>

### **[Explanation of Lookup code](https://helm-playground.com/cheatsheet.html#lookup)**

1. **Check if the Secret Already Exists**
   ```yaml
   {{ $previous := lookup "v1" "Secret" .Release.Namespace "some-secret" }}
   ```
   - `lookup` checks if a Kubernetes Secret named `some-secret` exists in the same namespace as your Helm release.
   - If it exists, its data is saved in `$previous`. If it doesn’t exist, `$previous` is empty (`null`).

---

2. **Decide Where `foobarPassword` Comes From**
   The code checks these conditions **in order**:

   #### **Option 1: Use an Existing Secret**
   ```yaml
   {{- if $previous }}
   foobarPassword: {{ $previous.data.foobarPassword | quote }}
   ```
   - If the Secret (`$previous`) exists:
     - Use the `foobarPassword` already stored in the Secret.
     - This prevents overwriting an existing password.

   **Example:** If the `some-secret` exists and already has:
   ```yaml
   data:
     foobarPassword: "existingPassword"
   ```
   The code will reuse `"existingPassword"`.

---

   #### **Option 2: Use a User-Provided Password**
   ```yaml
   {{- else if .Values.foobarPassword }}
   foobarPassword: {{ .Values.foobarPassword | b64enc | quote }}
   ```
   - If the Secret doesn’t exist **but** the user has provided a password in `values.yaml` (e.g., `foobarPassword: myPassword`):
     - Take the password from `.Values.foobarPassword`.
     - Encode it using `b64enc` (required for Kubernetes Secrets) and use it.

   **Example:** If `values.yaml` contains:
   ```yaml
   foobarPassword: "myUserPassword"
   ```
   The output will look like this:
   ```yaml
   foobarPassword: "bXlVc2VyUGFzc3dvcmQ="
   ```
   (This is `myUserPassword` in base64.)

---

   #### **Option 3: Generate a Random Password**
   ```yaml
   {{- else }}
   foobarPassword: {{ randAlphaNum 40 | b64enc | quote }}
   ```
   - If there’s no existing Secret and no password in `values.yaml`:
     - Generate a random password with 40 alphanumeric characters.
     - Encode it with `b64enc` and use it.

   **Example:** The generated password might look like this:
   ```yaml
   foobarPassword: "YWJjMTIzNDU2Nzg5MHJhbmRvbVBhc3M="
   ```
   (The actual value will vary each time because it’s random.)

---

### **Why This Logic is Useful**
- **Reusing Existing Data:** If a Secret already exists, it keeps the same password instead of overwriting it.
- **User Customization:** If a user wants a specific password, they can set it in `values.yaml`.
- **Fallback Security:** If neither of the above exists, it ensures a strong random password is always created.

---

### **Example Outputs**

Here’s how the rendered YAML will look in different scenarios:

#### **Scenario 1: Existing Secret**
If the Kubernetes Secret `some-secret` exists and has:
```yaml
data:
  foobarPassword: "existingPassword"
```

The rendered Secret will reuse the password:
```yaml
data:
  foobarPassword: "existingPassword"
```

---

#### **Scenario 2: Password in `values.yaml`**
If the user specifies a password in `values.yaml`:
```yaml
foobarPassword: "myUserPassword"
```

The rendered Secret will use the user-provided password:
```yaml
data:
  foobarPassword: "bXlVc2VyUGFzc3dvcmQ="
```

---

#### **Scenario 3: No Existing Secret or User-Provided Password**
If there’s no existing Secret and no `foobarPassword` in `values.yaml`, the password will be randomly generated:
```yaml
data:
  foobarPassword: "YWJjMTIzNDU2Nzg5MHJhbmRvbVBhc3M="
```

---

## <mark>**Fail**</mark>
```go
{{ if eq .Values.storageClassName "foobar1" }}
  # ...
{{ else if eq .Values.storageClassName "foobar2" }}
  # ...
{{ else }}
  {{ fail ".storageClassName is not recognized" }}
{{ end }}
```

* **`{{ fail ".storageClassName is not recognized" }}`**:
   - If none of the conditions are satisfied, this line will execute. The `fail` function causes Helm to terminate the rendering process and return an error message.
   - The message `".storageClassName is not recognized"` provides feedback indicating that an unrecognized value was provided for `storageClassName`.

---
## <mark>**Dates**</mark>

```go
{{ now | date "2006-01-02T15:04:05" }}
```

- **`now`**: This function retrieves the current date and time.
- **`date "2006-01-02T15:04:05"`**: This formats the current date and time according to the specified layout. In Go templates, the layout must be defined using a specific reference date (`2006-01-02T15:04:05`), which is a unique way of defining formats in Go.

---
## <mark>**Base64**</mark>
```go
{{ .Values.someData | b64enc }}
{{ .Values.someData | b64dec }}
```

* This expression takes the value of someData from the **values.yaml** file and **encodes** it in **Base64** format using the **b64enc function**.

---

## <mark>**UUIDs**</mark>
```go
id: {{ uuidv4 }}
```

* **{{ uuidv4 }}**:
  * This function call generates a new **UUID version 4**. 
  * **UUIDs** are **128-bit numbers** used to **uniquely identify information** in computer systems.
  * **Version 4 UUIDs** are **randomly** generated, making them suitable for use as **unique identifiers** in various applications

---

## <mark>**Crypto**</mark>

```go
{{ .Values.someData | sha256sum }}

{{ .Values.someData | encryptAES "secret key" }}
{{ .Values.someData | decryptAES "secret key" }}
```

### 1. SHA256 Hashing

```yaml
id: {{ .Values.someData | sha256sum }}
```

- **Purpose**: This expression takes the value of `someData` from the `values.yaml` file and computes its SHA256 hash using the `sha256sum` function.

### 2. AES Encryption

```yaml
{{ .Values.someData | encryptAES "secret key" }}
```

- **Purpose**: This expression encrypts the value of `someData` using AES (Advanced Encryption Standard) with the provided `"secret key"`.

### 3. AES Decryption

```yaml
{{ .Values.someData | decryptAES "secret key" }}
```

- **Purpose**: This expression decrypts a previously encrypted string using AES with the provided `"secret key"`.

---

## <mark>**useful Helm commands along with their descriptions**</mark>



| Command                                       | Description                                                                                      | Flags/Options                                                                                                 | Example                                                    |
|-----------------------------------------------|--------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------|------------------------------------------------------------|
| `helm install <release> <chart>`             | Install a chart and create a new release.                                                      | `--namespace <namespace>`, `--values <file>`, `--set <key=value>`, `--timeout <duration>`, `--wait`, `--atomic`, `--create-namespace` | `helm install my-release stable/mysql --namespace my-namespace` |
| `helm upgrade <release> <chart>`             | Upgrade a release to a new version of a chart or modify its configuration.                     | `--install`, `--values <file>`, `--set <key=value>`, `--timeout <duration>`, `--wait`, `--no-hooks`        | `helm upgrade my-release stable/mysql --set mysqlRootPassword=newpassword` |
| `helm rollback <release> [revision]`        | Roll back a release to a previous version.                                                     | None                                                                                                         | `helm rollback my-release 1`                              |
| **`helm uninstall <release>`**                | Delete a release and free up the resources associated with it.                                 | `--namespace <namespace>`                                                                                    | `helm uninstall my-release --namespace my-namespace`      |
| **`helm list`**                               | List all the installed releases.                                                                | `--all`, `--uninstalled`, `--max <number>`, `--filter <regex>`                                            | `helm list --all`                                        |
| **`helm status <release>`**                   | Get the status of a release, including last deployment time, namespace, state, and resources.  | `--revision=<revision>`, `--show-desc=false`, `--show-resources=false`, `-o, --output=<format>`           | `helm status my-release --show-desc=true`                |
| **`helm search repo <keyword>`**              | Search for available charts in Helm repositories.                                              | None                                                                                                         | `helm search repo mysql`                                  |
| **`helm repo add <name> <url>`**             | Add a Helm repository to your local environment.                                               | None                                                                                                         | `helm repo add stable https://charts.helm.sh/stable`     |
| **`helm repo update`**                        | Update the local cache of Helm repositories.                                                   | None                                                                                                         | `helm repo update`                                       |
| **`helm lint <chart>`**                       | Lint a chart to validate its syntax and configuration.                                         | None                                                                                                         | `helm lint my-chart`                                     |
| **`helm package <chart>`**                    | Package a chart directory into a compressed chart archive.                                     | None                                                                                                         | `helm package my-chart`                                   |
| **`helm pull <chart>`**                       | Download a chart and extract the archive’s contents into a directory.                          | `--untar`, `--untardir <directory>`                                                                         | `helm pull stable/mysql --untar --untardir ./mydir`     |
| **`helm history <release>`**                  | View the release history of a chart.                                                           | None                                                                                                         | `helm history my-release`                                 |
| **`helm show chart <chart>`**                 | Display information about a specific chart.                                                    | None                                                                                                         | `helm show chart stable/mysql`                            |
| **`helm get all <release>`**                  | Download all information about a release.                                                      | None                                                                                                         | `helm get all my-release`                                 |
| **`helm get values <release>`**               | Download the values file for a release.                                                        | None                                                                                                         | `helm get values my-release`                              |
| **Helpful Options for Install/Upgrade/Rollback**  | **Description**                                                                                  | **Example**                                                                                                |
| **`--timeout <duration>`**                    | Duration to wait for Kubernetes commands to complete (default is 5m0s).                        | Example: 5m, 10s                                                                                            |
| **`--wait`**                                  | Wait until all Pods are in a ready state before marking the release as successful.             | Use with install or upgrade commands                                                                         |
| **Set Values**                                | Set multiple values at once using comma separation.                                             | Example:  --set key1=value1,key2=value2                                                                     |

---

## <mark>**override specific values in a Helm chart**</mark>

### 1. Using the `--set` Flag

For quick and simple overrides, you can use the `--set` flag directly from the command line. This is ideal for making small adjustments without modifying a values file.

**Example Command:**

```bash
helm install my-nginx bitnami/nginx --set replicaCount=3
```

You can also set multiple values at once by separating them with commas:

```bash
helm install my-nginx bitnami/nginx --set replicaCount=3,service.type=NodePort
```

### 2. Using a Custom `values.yaml` File

For more complex configurations, it's better to create a separate `values.yaml` file where you define all your overrides in one place. This method helps keep your changes organized and maintainable.

**Example Custom Values File (`custom-values.yaml`):**

```yaml
replicaCount: 3
service:
  type: LoadBalancer
  port: 8080
```

**Deploying with Custom Values:**

```bash
helm install my-nginx bitnami/nginx -f custom-values.yaml
```

### 3. Combining `--set` with a Custom Values File

You can combine both methods for maximum flexibility. For instance, you might have a base `values.yaml` file but need to override a single value dynamically during deployment.

**Example Command:**

```bash
helm install my-nginx bitnami/nginx -f custom-values.yaml --set service.port=8081
```

This command will apply all settings from `custom-values.yaml`, but override the `service.port` value.

### 4. Checking Effective Values

After installing or upgrading a release, you can check which values are currently in effect using:

```bash
helm get values my-nginx
```

This command will show all the values being used for the release, including any custom overrides applied.

---
---

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

---
---

## ArgoCD

**Typical deployment into k8s**

<img src='images\gitops_1.png' alt='typical deployment' width='600'>

**GitOps**

* **Git is the single source for truth for Your Application as-well-as Infrastucture**.

<img src='images\gitops_2.png' alt='typical deployment' width='600'>

---
#### Key Points

* **Argo cd can be configure with Git repo for**
  * **manifests**
  * **helm**
  * **kustomize**

* **To configure argo with git we can execute**
  * **commands**
  * **manifest files (yaml)**

---
---

## <mark>**Argo CD Tutorial**</mark>

### **Argo CD Tutorial with a Kubernetes Manifest Example in a Git Repository**

- [Official Docs](https://argo-cd.readthedocs.io/en/stable/)
- [Git Repo Used in Class](https://github.com/dummyrepos/argocd-test-repo-nov24)

---

### **Step 1: Set Up the Git Repository**

1. **Create a Git Repository:**  
   Create a new Git repository on your preferred Git hosting service (e.g., GitHub, GitLab).

2. **Add a Sample Kubernetes Manifest:**  
   Clone your repository and add a sample Kubernetes manifest. Below is an example of a `guestbook` application.

**Directory Structure:**
```
my-repo/
├── manifests/
   ├── deployment.yaml
   ├── service.yaml
```

**`deployment.yaml`:**
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: guestbook
  labels:
    app: guestbook
spec:
  replicas: 3
  selector:
    matchLabels:
      app: guestbook
  template:
    metadata:
      labels:
        app: guestbook
    spec:
      containers:
      - name: guestbook
        image: redis:alpine
        ports:
        - containerPort: 6379
```

**`service.yaml`:**
```yaml
apiVersion: v1
kind: Service
metadata:
  name: guestbook
spec:
  selector:
    app: guestbook
  ports:
  - protocol: TCP
    port: 80
    targetPort: 6379
  type: ClusterIP
```

3. **Push the Files to Git:**  
   ```bash
   git add .
   git commit -m "Add guestbook Kubernetes manifests"
   git push origin main
   ```

---

### **Step 2: Install Argo CD**

Follow the installation steps provided in the main tutorial:

1. **Create the namespace:**
   ```bash
   kubectl create namespace argocd
   ```

2. **Install Argo CD:**
   ```bash
   kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
   ```

3. **Port-forward the service to access the UI:**
   ```bash
   kubectl port-forward svc/argocd-server -n argocd 8080:443
   ```

---

### **Step 3: Create the Argo CD Application**

1. **Login to Argo CD:**  
   Retrieve the admin password:
   ```bash
   kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath="{.data.password}" | base64 -d
   ```
   Login via the CLI:
   ```bash
   argocd login localhost:8080
   # or 
   argocd login localhost:8080 --username admin --password <YOUR_PASSWORD> --insecure
   ```

2. **Add Your Git Repository to Argo CD:**  
   Replace `<GIT_REPO_URL>` with the URL of your repository:
   ```bash
   argocd repo add <GIT_REPO_URL>
   ```

3. **Create an Argo CD Application:**  
   Run the following command to create an application in Argo CD:
   ```bash
   argocd app create guestbook \
     --repo <GIT_REPO_URL> \
     --path manifests \
     --dest-server https://kubernetes.default.svc \
     --dest-namespace default
     --sync-policy automated
   ```

   Example:
   ```bash
   argocd app create guestbook \
     --repo https://github.com/your-username/my-repo.git \
     --path manifests \
     --dest-server https://kubernetes.default.svc \
     --dest-namespace default
   ```

---

### **Step 4: Sync the Application**

1. **Sync the Application via CLI:**  
   ```bash
   argocd app sync guestbook
   ```

2. **Sync the Application via UI:**
   - Access the Argo CD web UI at `https://localhost:8080`.
   - Login using the admin credentials.
   - Click on the `guestbook` application.
   - Click the “Sync” button to deploy the application.

3. **Verify the Deployment:**  
   Check the resources in the Kubernetes cluster:
   ```bash
   kubectl get all -n default
   ```

---

### **Step 5: Monitor and Manage the Application**

1. **Check Application Status:**  
   ```bash
   argocd app get guestbook
   ```

2. **View Logs:**  
   To view logs of a specific pod:
   ```bash
   kubectl logs <POD_NAME> -n default
   ```

3. **Update the Application:**
   - Modify the manifests in the Git repository.
   - Commit and push the changes.
   - Argo CD will detect the changes and show the application as `OutOfSync`.

4. **Sync Again:**  
   ```bash
   argocd app sync guestbook
   ```

---

### **Step 6: Enable Automatic Sync (Optional)**

To enable auto-sync for the `guestbook` application:

```bash
argocd app set guestbook --sync-policy automated
```

---

### **Step 7: Clean Up**

1. **To delete the application and resources:**
   ```bash
   argocd app delete guestbook
   ```

2. **To uninstall Argo CD:**
   ```bash
   kubectl delete namespace argocd
   ```

---
---
Here’s the formatted version for your notes:  

---

## <mark>**Argo CD Tutorial with Helm Chart Deployment**</mark>

---

### **Step 1: Set Up the Git Repository with Helm Charts**  

**Create a Git Repository:**  
- Create a new repository to store your Helm chart or use an existing one.  

**Add a Sample Helm Chart:**  
- Create a Helm chart using `helm create` or download an existing one.  

**Example directory structure for a Helm chart:**  
```
my-repo/
└── helm/
    └── guestbook/
        ├── Chart.yaml
        ├── values.yaml
        ├── templates/
        │   ├── deployment.yaml
        │   └── service.yaml
```  

**`Chart.yaml`:**  
```yaml
apiVersion: v2
name: guestbook
description: A sample Helm chart for a Kubernetes application
version: 1.0.0
appVersion: 1.0.0
```  

**`values.yaml`:**  
```yaml
replicas: 3
image:
  repository: redis
  tag: alpine
service:
  type: ClusterIP
  port: 6379
```  

**`templates/deployment.yaml`:**  
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ .Chart.Name }}
  labels:
    app: {{ .Chart.Name }}
spec:
  replicas: {{ .Values.replicas }}
  selector:
    matchLabels:
      app: {{ .Chart.Name }}
  template:
    metadata:
      labels:
        app: {{ .Chart.Name }}
    spec:
      containers:
      - name: {{ .Chart.Name }}
        image: "{{ .Values.image.repository }}:{{ .Values.image.tag }}"
        ports:
        - containerPort: {{ .Values.service.port }}
```  

**`templates/service.yaml`:**  
```yaml
apiVersion: v1
kind: Service
metadata:
  name: {{ .Chart.Name }}
spec:
  type: {{ .Values.service.type }}
  ports:
  - port: 80
    targetPort: {{ .Values.service.port }}
  selector:
    app: {{ .Chart.Name }}
```  

**Push the Chart to Git:**  
```bash
git add .
git commit -m "Add Helm chart for guestbook application"
git push origin main
```  

---

### **Step 2: Install Argo CD**  
Follow the steps in the [Argo CD installation tutorial](https://argo-cd.readthedocs.io/en/stable/getting_started/). Ensure Argo CD is installed and running in your Kubernetes cluster.  

---

### **Step 3: Deploy the Helm Chart Using Argo CD**  

**Add Your Git Repository to Argo CD:**  
```bash
argocd repo add <GIT_REPO_URL>
```  

**Create an Argo CD Application for the Helm Chart:**  
Replace `<GIT_REPO_URL>` and `<APP_NAME>` with your repository URL and application name.  
```bash
argocd app create guestbook-helm \
--repo <GIT_REPO_URL> \
--path helm/guestbook \
--dest-server https://kubernetes.default.svc \
--dest-namespace default \
--helm-set replicas=3 \
--helm-set image.repository=redis \
--helm-set image.tag=alpine
```  

**Example:**  
```bash
argocd app create guestbook-helm \
--repo https://github.com/your-username/my-repo.git \
--path helm/guestbook \
--dest-server https://kubernetes.default.svc \
--dest-namespace default
```  

**Sync the Application:**  
```bash
argocd app sync guestbook-helm
```  

---

### **Step 4: Use Helm Repository (Optional)**  

**Add the Helm Repository:**  
```bash
argocd repo add https://charts.bitnami.com/bitnami --type helm
```  

**Create an Application Using a Helm Chart:**  
```bash
argocd app create guestbook-helm \
--repo https://charts.bitnami.com/bitnami \
--helm-chart redis \
--revision 17.4.0 \
--dest-server https://kubernetes.default.svc \
--dest-namespace default \
--helm-set replicaCount=3
```  

**Sync the Application:**  
```bash
argocd app sync guestbook-helm
```  

---

### **Step 5: Monitor and Manage the Application**  

**Check Application Status:**  
```bash
argocd app get guestbook-helm
```  

**View Application Details in the Web UI:**  
- Access the Argo CD web UI at `https://localhost:8080`.  
- Navigate to the `guestbook-helm` application to see deployment details, status, and logs.  

**Update the Helm Values:**  
```bash
argocd app set guestbook-helm --helm-set replicas=5
argocd app sync guestbook-helm
```  

**Rollback to a Previous Version:**  
```bash
argocd app rollback guestbook-helm <REVISION_NUMBER>
```  

---

### **Step 6: Enable Auto-Sync for Helm Applications**  
```bash
argocd app set guestbook-helm --sync-policy automated
```  

---

### **Step 7: Clean Up**  

**Delete the Helm application and resources:**  
```bash
argocd app delete guestbook-helm
```  

**Uninstall Argo CD:**  
```bash
kubectl delete namespace argocd
```  

---
---
## <mark>**Argo CD Git repository configuration in yaml**</mark>

* Example of an **Argo CD Git repository configuration** in YAML format. 
* This configuration can be used to define a Git repository in Argo CD using a `ConfigManagementPlugin` or via the `Application` manifest.

---

### **Git Repository Configuration Using `Application` Manifest**

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: example-app
  namespace: argocd
spec:
  project: default
  source:
    repoURL: https://github.com/your-org/your-repo.git
    targetRevision: HEAD  # Can be a branch, tag, or commit hash
    path: manifests/example-app
  destination:
    server: https://kubernetes.default.svc
    namespace: default
  syncPolicy:
    automated:
      prune: true          # Automatically delete resources that are no longer in Git
      selfHeal: true       # Automatically sync out-of-sync resources
```

---

### **Key Fields Explained**
1. **`metadata.name`**: The name of the Argo CD application.
2. **`metadata.namespace`**: The namespace where Argo CD is installed (default: `argocd`).
3. **`spec.source.repoURL`**: The URL of your Git repository.
4. **`spec.source.targetRevision`**: Specifies the Git branch, tag, or commit to track.
5. **`spec.source.path`**: The path in the repository where the manifests are located.
6. **`spec.destination.server`**: The API server URL for the Kubernetes cluster.
7. **`spec.destination.namespace`**: The namespace where the application will be deployed.
8. **`spec.syncPolicy.automated`**: Enables automatic synchronization.

---

### **Example for Multiple Applications**
If you have multiple applications in a single repository, you can create separate `Application` manifests for each.

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: app1
  namespace: dev
spec:
  project: default
  source:
    repoURL: https://github.com/your-org/your-repo.git
    targetRevision: develop
    path: manifests/app1
  destination:
    server: https://kubernetes.default.svc
    namespace: app1
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
---
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: app2
  namespace: qa
spec:
  project: default
  source:
    repoURL: https://github.com/your-org/your-repo.git
    targetRevision: qa
    path: manifests/app2
  destination:
    server: https://kubernetes.default.svc
    namespace: app2
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
```

---

### **Apply the Manifest**
Save the YAML to a file, e.g., `argocd-app.yaml`, and apply it using `kubectl`:
```bash
kubectl apply -f argocd-app.yaml
```

---

### **Optional: Add Credentials for a Private Git Repository**
If your Git repository is private, you'll need to configure repository credentials in Argo CD:
```bash
argocd repo add https://github.com/your-org/your-private-repo.git \
  --username <USERNAME> \
  --password <PASSWORD>
```

Alternatively, create a `Secret` to store credentials:
```yaml
apiVersion: v1
kind: Secret
metadata:
  name: repo-creds
  namespace: argocd
  labels:
    argocd.argoproj.io/secret-type: repository
data:
  url: aHR0cHM6Ly9naXRodWIuY29tL3lvdXItb3JnL3lvdXItcmVwby5naXQ=  # Base64 of repo URL
  username: <BASE64_ENCODED_USERNAME>
  password: <BASE64_ENCODED_PASSWORD>
```
---  
---

## <mark>Well-Known Kubernetes Issues and How to Resolve Them</mark>

- [K8s Troubleshooting Docs](https://komodor.com/learn/kubernetes-troubleshooting-the-complete-guide/)

* CreateContainerConfigError
* ImagePullBackOff or ErrImagePull
* CrashLoopBackOff
* Kubernetes Node Not Ready

---
---

## <mark>**DevSecOps**</mark>

<img src='images\flow.png' alt='gitops flow' width='700'>


<img src='images\DevSecOps.png' alt='DevSecOps_pipeline' width='650'>

### **Code Level Security**
- **SCA (Software Composition Analysis)**:  
  Checks for vulnerabilities in third-party dependencies.
- **SAST (Static Application Security Testing)**:  
  Identifies security issues within the code itself.

### **Post-Deployment Security**
- **DAST (Dynamic Application Security Testing)**:  
  Tests the running application for vulnerabilities by simulating attacks.

---

## **Understanding CVE in Cybersecurity**

### **CVE Definition**
- **CVE (Common Vulnerabilities and Exposures)**:  
  A standardized system that assigns unique IDs to publicly known cybersecurity vulnerabilities.

### **Origin and Purpose**
- **Founded in 1999** by the **MITRE Corporation**.  
  Funded by the U.S. Department of Homeland Security.  
  Facilitates standardized communication and tracking of vulnerabilities.

### **How CVE Works**
- Each CVE has:
  - A **unique identifier** (e.g., CVE-YYYY-NNNNN).
  - A brief **description** of the vulnerability.
  - **References** to additional resources.

### **Criteria for Inclusion**
1. **Independently Fixable**: Resolvable without addressing other issues.  
2. **Vendor Acknowledgment**: Recognized by the vendor as a security flaw.  
3. **Single Codebase Impact**: Affects a specific software or product.

### **Importance of CVE**
- **Facilitates Communication**: Standardized IDs simplify discussions.  
- **Enhances Security Management**: Helps prioritize and address vulnerabilities.  
- **Supports Risk Management**: Tools reference CVEs for automated detection.

### **Key CVE Resources**
1. **MITRE CVE Database**: The primary source for CVEs.  
2. **National Vulnerability Database (NVD)**: Provides enriched details like severity scores.  
3. **CVE Details**: Offers exploits, tools, and additional advisory links.  
4. **Vendor Databases**: Tailored CVE data for specific products.

---

## **OWASP (Open Web Application Security Project)**

### **Overview**
- A nonprofit organization founded in **2001**, aimed at improving software security.
- Offers free, community-driven resources and tools for secure application development.

### **Key Initiatives**
1. **OWASP Top 10**:  
   Lists the most critical web application security risks.  
   Example: SQL Injection, XSS (Cross-Site Scripting).
2. **Community-driven**:  
   Open collaboration for innovation and shared knowledge.
3. **Free Resources**:  
   All tools and documentation are accessible to the public.  
4. **Global Reach**:  
   Over **250 local chapters worldwide** promoting security awareness.

### **Mission and Vision**
- **Mission**: Empower organizations to develop secure software through education, tools, and best practices.  
- **Vision**: Eliminate insecure software by addressing key vulnerabilities.

---

## <mark>**WorkShop**</mark>

<img src='images\DevSecOps_01.png' alt='DevSecOps_pipeline' width='600'>

[**Github Repo**](https://github.com/mydummyrepo/chess-game-tutorial) \
[**Actions**](https://github.com/mydummyrepo/chess-game-tutorial/actions)