# Parameters

## <mark>**metadata**</mark>

[Refer Here](https://kubernetes.io/docs/reference/labels-annotations-taints/) for Well-Known k8s Labels, Annotations and Taints

| **Field**                       | **Usage Frequency** | **Description**                                                                                                                      |
|---------------------------------|---------------------|--------------------------------------------------------------------------------------------------------------------------------------|
| **name**                        | Very High           | The unique identifier for the resource within its namespace.                                                                         |
| **namespace**                   | Very High           | Specifies the namespace in which the resource resides; helps organize resources in a cluster.                                        |
| **labels**                      | High                | Key/value pairs used to categorize and select objects, essential for grouping and managing resources.                               |
| **annotations**                 | High                | Key/value pairs for attaching non-identifying metadata; useful for storing additional information about the resource that might be useful for tools or libraries interacting with the Kubernetes API..                |
| **creationTimestamp**           | Medium              | Indicates when the resource was created; automatically set by the system.                                                            |
| **resourceVersion**             | Medium              | A string that indicates the internal version of this object; used for tracking changes and ensuring consistency.                    |
| **uid**                         | Medium              | A unique identifier assigned to the resource by Kubernetes, ensuring unique identification across namespaces.                       |
| **deletionGracePeriodSeconds**  | Low                 | Specifies how long to wait before forcibly deleting a resource after deletion is requested; not always used.                        |
| **deletionTimestamp**           | Low                 | Indicates when the resource is scheduled for deletion; set by the server when a deletion request is made.                          |
| **finalizers**                  | Low                 | List of identifiers for components that must perform cleanup tasks before the resource can be deleted; must be empty for deletion.   |

---
---

## <mark>**PodSpec**</mark>

| **Field**                          | **Type**                | **Description**                                                                                                                      |
|------------------------------------|-------------------------|--------------------------------------------------------------------------------------------------------------------------------------|
| **containers**                     | Container array         | List of containers belonging to the pod. There must be at least one container in a Pod, and it cannot be modified after creation.   |
| **initContainers**                 | Container array         | List of initialization containers executed before the main containers. They must complete successfully for the pod to start.          |
| **restartPolicy**                  | string                  | Defines the restart policy for all containers within the pod. Options are `Always`, `OnFailure`, or `Never`. Default is `Always`.    |
| **terminationGracePeriodSeconds**  | integer                 | Duration in seconds for graceful termination of the pod. Defaults to 30 seconds if not specified.                                   |
| **volumes**                        | Volume array            | List of volumes that can be mounted by containers in the pod.                                                                         |
| **nodeSelector**                   | object                  | Selector that must match a node's labels for the pod to be scheduled on that node.                                                  |
| **affinity**                       | Affinity                | Scheduling constraints for the pod, allowing for more complex placement rules based on node labels and conditions.                  |
| **tolerations**                    | Toleration array        | Specifies tolerations for nodes that have taints, allowing the pod to be scheduled on those nodes.                                   |
| **dnsPolicy**                      | string                  | DNS policy for the pod; defaults to `ClusterFirst`. Options include `ClusterFirst`, `Default`, or `None`.                           |
| **serviceAccountName**             | string                  | The name of the ServiceAccount to use to run this pod, allowing it to access Kubernetes API resources.                               |

---
### <u>**Explanation**</u>:


### <mark>**1. Affinity**</mark>

**Affinity** is a set of rules used to influence the scheduling of Pods onto nodes. It allows you to specify constraints that control where a pod is placed in the cluster based on factors like node labels, pod labels, or other conditions. 

#### Types of Affinity:

- **Node Affinity**: This defines rules to constrain which nodes your pod can be scheduled on based on node labels. It is similar to **nodeSelector** but more expressive.
  
- **Pod Affinity**: This defines rules to specify that a pod should be scheduled on a node if that node is already running specific other pods (based on labels).
  
- **Pod Anti-Affinity**: This defines rules to ensure that a pod is not scheduled on a node if that node is already running specific other pods.

---
### <mark>**2 ServiceAccountName**</mark>

The **serviceAccountName** field specifies the name of the **ServiceAccount** that the pod should use for authentication and authorization when interacting with the Kubernetes API server. 

- **ServiceAccount** is an identity for processes that run in a pod. The pod can then use this identity to perform actions (e.g., reading secrets, interacting with other Kubernetes resources).
- If you do not specify a service account, the pod uses the default service account in the namespace.

---
---
### <mark>**containers**</mark>

| **Field**                     | **Type**                | **Description**                                                                                                                      |
|-------------------------------|-------------------------|--------------------------------------------------------------------------------------------------------------------------------------|
| **name**                      | string                  | The name of the container. Must be unique within the pod.                                                                             |
| **image**                     | string                  | The container image to use, including the repository and tag (e.g., `nginx:latest`).                                               |
| **command**                   | string array            | The command to run when the container starts. Overrides the default CMD in the image.                                               |
| **args**                      | string array            | Arguments to pass to the command when starting the container.                                                                         |
| **ports**                     | ContainerPort array     | List of ports to expose from the container.                                                                                          |
| **env**                       | EnvVar array            | Environment variables to set in the container.                                                                                       |
| **resources**                 | ResourceRequirements     | Resource requests and limits for CPU and memory for the container.                                                                    |
| **volumeMounts**             | VolumeMount array       | List of volumes to mount into the container's filesystem.                                                                             |
| **livenessProbe**             | Probe                   | Configuration for a liveness probe to check if the container is running.                                                             |
| **livenessProbe options**      | - `httpGet`            | HTTP GET request to check if the container is alive.                                                                                 |
|                               | - `exec`                | Command to run inside the container to check if it is alive.                                                                          |
|                               | - `tcpSocket`           | TCP socket check to determine if the container is alive.                                                                             |
| **readinessProbe**            | Probe                   | Configuration for a readiness probe to check if the container is ready to accept traffic.                                            |
| **readinessProbe options**     | - `httpGet`            | HTTP GET request to check if the container is ready.                                                                                 |
|                               | - `exec`                | Command to run inside the container to check if it is ready.                                                                          |
|                               | - `tcpSocket`           | TCP socket check to determine if the container is ready.                                                                             |
| **startupProbe**              | Probe                   | Configuration for a startup probe to check if the container has started successfully.                                                |
| **startupProbe options**       | - `httpGet`            | HTTP GET request to check if the startup process is complete.                                                                         |
|                               | - `exec`                | Command to run inside the container to verify startup completion.                                                                     |
|                               | - `tcpSocket`           | TCP socket check to determine if startup is successful.                                                                              |
| **securityContext**           | SecurityContext         | Security options for the container, such as user ID, capabilities, and privilege settings.                                            |
| **imagePullPolicy**           | string                  | Policy for pulling images: `Always`, `IfNotPresent`, or `Never`. Default is `IfNotPresent`.                                           |

### **Explanation**
### <mark>1. volumeMounts</mark>

In Kubernetes, `volumeMounts` are used to specify how and where a volume should be mounted within a container's filesystem. This allows containers to access shared storage resources, enabling data persistence and sharing among different containers in a pod.

#### Key Features of `volumeMounts`

| **Field**            | **Type**              | **Description**                                                                                                                      |
|----------------------|-----------------------|--------------------------------------------------------------------------------------------------------------------------------------|
| **name**             | string                | The name of the volume mount. This must match the name of a volume defined in the pod's `volumes` section.                         |
| **mountPath**        | string                | The path within the container where the volume should be mounted. This is where the application inside the container can access the data. |
| **subPath**          | string (optional)     | A specific path within the volume to mount. This allows mounting only a portion of the volume instead of the entire volume.         |
| **readOnly**         | boolean (optional)    | If set to `true`, the volume will be mounted as read-only. This prevents any write operations to that volume from within the container. |
| **mountPropagation**  | string (optional)     | Controls how mounts are propagated between the host and containers. Options include `None`, `HostToContainer`, and `Bidirectional`.   |

### <mark>2. securityContext</mark>
The `securityContext` in Kubernetes is a specification that defines the security attributes and settings for a pod or container. It allows you to control aspects such as user permissions, capabilities, and other security-related configurations to enhance the security posture of your applications running in a Kubernetes cluster.

#### Key Features of `securityContext`

| **Field**                          | **Type**                | **Description**                                                                                                                      |
|------------------------------------|-------------------------|--------------------------------------------------------------------------------------------------------------------------------------|
| **runAsUser**                      | integer                 | Specifies the user ID (UID) that the container should run as. If not set, the container runs as the default user defined in the image. |
| **runAsGroup**                     | integer                 | Specifies the group ID (GID) that the container should run as.                                                                       |
| **fsGroup**                        | integer                 | A GID that applies to any files created by the container. It ensures that files are accessible to processes running under this group. |
| **privileged**                     | boolean                 | If set to `true`, it gives the container elevated privileges, allowing it to perform operations that are usually restricted.           |
| **capabilities**                   | Capabilities            | Adds or drops specific Linux capabilities for the container, allowing fine-grained control over what the container can do.            |
| **readOnlyRootFilesystem**         | boolean                 | If set to `true`, it mounts the container's root filesystem as read-only, enhancing security by preventing write access.               |
| **allowPrivilegeEscalation**       | boolean                 | Controls whether a process can gain more privileges than its parent process. Setting it to `false` helps mitigate privilege escalation attacks. |
| **procMount**                      | string                  | Specifies how the /proc filesystem is mounted in the container. Options include `Default` and `Unmasked`.                             |
| **seccompProfile**                 | SeccompProfile          | Specifies a Seccomp profile to limit system calls available to the container, enhancing security by reducing attack surface.           |
| **appArmorProfile**                | string                  | Specifies an AppArmor profile to apply to the container, providing an additional layer of security through mandatory access controls.  |
| **seLinuxOptions**                 | SELinuxOptions          | Defines SELinux options for the container, controlling access based on SELinux policies.                                             |

---
---

