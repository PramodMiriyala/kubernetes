## Elastic Kubernetes Service (EKS)

EKS is Kubernetes as a service offering provided by AWS, enabling users to deploy, manage, and scale Kubernetes clusters.

### AWS Service Integrations

#### Private Integrations
- **VPC CNI**: Assigns each pod an IP address from the VPC range.
- **Load Balancer Integration**:
  - Supports linking AWS services to AWS Load Balancers.
  - Includes the Application Load Balancer (ALB) Ingress Controller.
- **Storage Integrations**:
  - Provides Container Storage Interface (CSI) implementations for:
    - **EBS** (Elastic Block Store)
    - **EFS** (Elastic File System)
    - **FSx**
    - **S3**

### Cluster Node Autoscaling
- **Cluster Autoscaler**: Automatically adjusts the number of nodes in the cluster based on resource requirements.
- **Karpenter**: Provides fast and efficient provisioning of new nodes.

### Identity and Access Management (IAM) Integration
- EKS can integrate with:
  - **IAM** for AWS users.
  - External identity providers (e.g., SAML, OIDC).

### EKS Offerings
1. **EKS (Fully on AWS)**
   - Compute options:
     - **EC2**
     - **Fargate** (serverless option)
2. **EKS on Outposts**
   - Hybrid cloud option for on-premises workloads(on aws rented servers).
3. **EKS Anywhere**
   - Kubernetes distribution for on-premises environments.

### EKS Cluster Creation Options
- **AWS Management Console**
- **AWS CLI**
- **eksctl**: [eksctl.io](https://eksctl.io/)
- **Terraform** (CI/CD pipeline integration)

---

### Key Resources and References

#### eksctl
- Documentation: [eksctl.io](https://eksctl.io/)
- Installation Guide: [eksctl.io/installation](https://eksctl.io/installation)
- Schema: [eksctl.io/usage/schema](https://eksctl.io/usage/schema)
- [Examples](https://github.com/eksctl-io/eksctl/blob/main/examples/)

```yaml
# ekscluster.yaml
apiVersion: eksctl.io/v1alpha5
kind: ClusterConfig
metadata:
  name: basic-cluster
  region: ap-south-1
nodeGroups:
  - name: ng-1
    instanceType: t3.large
    desiredCapacity: 2
    volumeSize: 20
    ssh:
      allow: true # will use ~/.ssh/id_rsa.pub as the default ssh key
```
```yaml
eksctl create cluster -f ekscluster.yaml
```
#### Persistent Volumes
- Configure IAM roles for persistent volumes: [AWS Documentation](https://docs.aws.amazon.com/eks/latest/userguide/ebs-csi.html)

#### Helm Charts
- Repository: [aws/eks-charts](https://github.com/aws/eks-charts)
- Common charts:
  - Storage classes.
  - AWS Secrets Manager integration.

### AWS Service Integrations

#### Network-Based Resources
- Examples: RDS, EC2, ECS.
- Best Practices:
  - Deploy resources and EKS in the same VPC.
  - Use VPC peering for private connections.

#### Non-Network-Based Resources
- Examples: S3, DynamoDB.
- Use VPC endpoints for access.

#### IAM Roles
- Assign appropriate IAM roles to the Kubernetes cluster for resource access.

#### Cluster Configuration Example
- Example configuration: [GitHub Commit](https://github.com/asquarezone/KubernetesZone/commit/a7a214213bf706def3805d3045634fa2e37a3fc9)

### Cluster Autoscaling
- **Cluster Autoscaler**:
  - Works similarly to Auto Scaling Groups (ASGs).
- **Karpenter**:
  - Faster provisioning of nodes.
  - Documentation: [karpenter.sh](https://karpenter.sh/)
  - Setup Guide: [karpenter.sh/docs](https://karpenter.sh/docs/getting-started/getting-started-with-karpenter/)


| Feature                             | Cluster Autoscaler                          | Karpenter                                   |
|-------------------------------------|--------------------------------------------|---------------------------------------------|
| **Scaling Mechanism**               | Operates at the node group level; scales predefined groups based on pending pods. | Dynamically provisions individual nodes based on real-time pod requirements. |
| **Resource Utilization**            | May lead to underutilized nodes due to fixed node types. | Optimizes resource usage through "just-in-time" scaling and advanced consolidation features. |
| **Cloud Provider Support**          | Supports multiple cloud providers (AWS, GCP, Azure). | Primarily focused on AWS but expanding to other providers like Azure and Alibaba Cloud. |
| **Spot Instance Support**           | Supported but limited in managing interruptions. | First-class support for Spot instances with advanced interruption handling capabilities. |
| **Scaling Speed**                   | Slower scaling due to reliance on cloud provider abstractions (e.g., Auto Scaling Groups). | Faster scaling by directly interacting with cloud provider APIs for immediate provisioning. |
| **User Friendliness**               | More complex configuration due to multiple node groups and policies. | Simplified setup with intelligent scheduling and configurations tailored to workloads. |
| **Operational Characteristics**     | Requires management of multiple node groups; less flexible for diverse workloads. | Focused on simplified operations with features like consolidation and expiry for Spot instances. |

### Backups
- Use **Velero** for backup and restore:
  - Velero: [velero.io](https://velero.io/)
  - Velero with EKS: [AWS Blog](https://aws.amazon.com/blogs/containers/backup-and-restore-your-amazon-eks-cluster-resources-using-velero/)

### Upgrades
- Follow AWS documentation and best practices for cluster and node upgrades.

---

## <mark>**Storing Secrets in Kubernetes**</mark>

Kubernetes secrets are base64-encoded values, requiring secure storage solutions for sensitive data.

### Popular Vaults 
- **HashiCorp Vault**
- **AWS Secrets Manager**
- **Azure Key Vault**

### Mounting Secrets
- All secrets can be mounted with the help of:
  - **CSI Driver**
  - **SecretProviderClass**

### <mark>**Detailed Notes on Using Azure Key Vault as Kubernetes Secrets**</mark>

1. **Install the Azure Key Vault Provider for Secrets Store CSI Driver**:
   Deploy the Secrets Store CSI Driver in your Kubernetes cluster to facilitate integration with Azure Key Vault.

   ```bash
   kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/secrets-store-csi-driver/main/deploy/secrets-store-csi-driver-installer.yaml
   ```

2. **Create an Azure Key Vault**:
   Create an Azure Key Vault and store your secrets:

   ```bash
   az keyvault create --name <YourKeyVaultName> --resource-group <YourResourceGroup>
   az keyvault secret set --vault-name <YourKeyVaultName> --name <SecretName> --value <SecretValue>
   ```

3. **Create a SecretProviderClass Resource**:
   Define a `SecretProviderClass` resource that specifies how to access your Azure Key Vault:

   ```yaml
   apiVersion: secrets-store.csi.k8s.io/v1alpha1
   kind: SecretProviderClass
   metadata:
     name: my-secrets-provider
   spec:
     provider: azure
     parameters:
       usePodIdentity: "false"  # Set to true if using managed identity
       keyvaultName: "<YourKeyVaultName>"
       objects: |
         array:
           - |
             objectName: <SecretName>
             objectType: secret  # can be secret, key, or certificate
       tenantId: "<YourTenantId>"
   ```

4. **Create a Pod that Uses the Secrets**:
   Reference the `SecretProviderClass` in your pod specification to mount the secrets:

   ```yaml
   apiVersion: v1
   kind: Pod
   metadata:
     name: my-app
   spec:
     containers:
       - name: my-container
         image: my-image
         volumeMounts:
           - mountPath: "/mnt/secrets"
             name: secret-volume
     volumes:
       - name: secret-volume
         csi:
           driver: secrets-store.csi.k8s.io
           readOnly: true
           volumeAttributes:
             secretProviderClass: "my-secrets-provider"
   ```
---
To configure an EKS cluster with IAM policies for CSI drivers using an `eksctl` config file, follow the steps below. This setup will ensure that your Kubernetes pods can interact with AWS services securely.

### <mark>Example `eksctl` Config File</mark>

Here’s a sample `eksctl` configuration file that creates an EKS cluster and includes an IAM policy for the Amazon EBS CSI driver:

```yaml
apiVersion: eksctl.io/v1alpha5
kind: ClusterConfig

metadata:
  name: my-cluster
  region: us-west-2

iam:
  withOIDC: true  # Enable OIDC for IAM roles
  serviceAccounts:
    - metadata:
        name: ebs-csi-controller-sa  # Service account name
        namespace: kube-system        # Namespace where the service account will be created
      attachPolicyARNs:
        - arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy  # Attach the managed policy for EBS CSI

# Optional: Add-ons configuration
addons:
  - name: vpc-cni
    version: latest
```

### Steps to Deploy

1. **Create the Cluster**:
   Use the above configuration file to create your EKS cluster with the necessary IAM roles and policies.

   ```bash
   eksctl create cluster -f eks-cluster-config.yaml
   ```

2. **Verify IAM Role Creation**:
   After the cluster is created, verify that the service account and IAM role have been created correctly:

   ```bash
   kubectl get serviceaccounts -n kube-system
   ```

3. **Deploy the EBS CSI Driver**:
   You can deploy the Amazon EBS CSI driver using Helm or kubectl. Here’s how to do it using Helm:

   ```bash
   helm repo add aws-ebs-csi-driver https://kubernetes-sigs.github.io/aws-ebs-csi-driver/
   helm install aws-ebs-csi-driver aws-ebs-csi-driver/aws-ebs-csi-driver --namespace kube-system --set controller.serviceAccount.create=false --set controller.serviceAccount.name=ebs-csi-controller-sa
   ```


### <mark>Configuration Breakdown</mark>

```yaml
apiVersion: eksctl.io/v1alpha5
kind: ClusterConfig
```
- **apiVersion**: Specifies the version of the `eksctl` API being used.
- **kind**: Indicates that this configuration is for a `ClusterConfig`, which defines settings for creating an EKS cluster.

```yaml
metadata:
  name: my-cluster
  region: us-west-2
```
- **metadata**: Contains metadata about the cluster.
  - **name**: The name assigned to the EKS cluster, in this case, "my-cluster".
  - **region**: The AWS region where the cluster will be created, here it is set to "us-west-2".

```yaml
iam:
  withOIDC: true  # Enable OIDC for IAM roles
```
- **iam**: This section configures IAM roles and policies for the cluster.
  - **withOIDC**: When set to true, it enables OpenID Connect (OIDC) for associating IAM roles with Kubernetes service accounts. This allows pods to use IAM roles for accessing AWS resources.

```yaml
serviceAccounts:
  - metadata:
      name: ebs-csi-controller-sa  # Service account name
      namespace: kube-system        # Namespace where the service account will be created
    attachPolicyARNs:
      - arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy  # Attach the managed policy for EBS CSI
```
- **serviceAccounts**: Defines service accounts that can be used by pods in Kubernetes.
  - **metadata**:
    - **name**: The name of the service account, "ebs-csi-controller-sa", which will be used by the EBS CSI driver.
    - **namespace**: The Kubernetes namespace where this service account will be created, typically "kube-system" for system components.
  - **attachPolicyARNs**: Lists IAM policies to attach to the service account. Here, it attaches the managed policy `AmazonEBSCSIDriverPolicy`, which grants permissions necessary for managing EBS volumes.

```yaml
# Optional: Add-ons configuration
addons:
  - name: vpc-cni
    version: latest
```
- **addons**: This section is optional and can be used to specify additional components or add-ons to install with the cluster.
  - **name**: The name of the add-on, in this case, "vpc-cni", which is responsible for providing networking capabilities within the EKS cluster.
  - **version**: Specifies the version of the add-on to install; "latest" indicates that the most recent version should be used.

### Additional Notes

- **Custom IAM Policies**: If you need additional permissions beyond what is provided by the managed policy, you can create a custom IAM policy and attach it to the service account. You would need to define your policy in a JSON file and use `aws iam create-policy` to create it, then attach it similarly as shown in the config above.
  
- **Trust Relationship**: Ensure that your IAM role has a trust relationship with the OIDC provider associated with your EKS cluster. This is automatically handled when you use `eksctl` with `withOIDC: true`.

- **Using Other CSI Drivers**: If you're using other CSI drivers (like for Amazon FSx or EFS), you would follow similar steps but adjust the policies and service account names accordingly.

---
---

## <mark>**Azure Kubernetes Service (AKS)**</mark>

Azure Kubernetes Service (AKS) is a managed Kubernetes offering by Microsoft Azure, providing simplified cluster management and scaling.

### Features
- **Cluster Autoscaling**: Automatically adjusts the cluster size based on demand.
- **Node Pools**:
  - Support for multiple node pools.
  - Includes GPU-enabled and Spot instances.
- **Identity Integration**:
  - Azure Active Directory (AAD) integration for authentication and authorization.
- **Monitoring**:
  - Azure Monitor integration for cluster performance tracking.
  - Prometheus and Grafana support.
- **Networking**:
  - Azure CNI or Kubenet for networking.
  - Integration with Azure Load Balancer and Application Gateway.
- **Storage Options**:
  - Azure Disk, Azure Files, and Azure Blob Storage support.
- **Security Features**:
  - Role-Based Access Control (RBAC).
  - Managed identities for Kubernetes.
  - Integration with Azure Key Vault for secrets management.

### Deployment Options
- **Azure Portal**
- **Azure CLI**
- **ARM Templates**
- **Terraform**

### Key References
- Documentation: [Azure Kubernetes Service Documentation](https://learn.microsoft.com/en-us/azure/aks/)
- Azure CLI: [AKS CLI Commands](https://learn.microsoft.com/en-us/cli/azure/aks)
- [Azure Secrets Store CSI Driver](https://learn.microsoft.com/en-us/azure/aks/csi-secrets-store-driver)
- https://github.com/Azure-Samples/serviceconnector-aks-samples

---
---

## Service Mesh (Istio)
* A service mesh is a software layer that handles all communication between services in applications.

### [Refer Here](https://aws.amazon.com/what-is/service-mesh/) for Service Mesh  

---

#### Features  
- <mark>**mTLS**</mark>

<img src='images\img_40.png' alt='mtls' width='450'>

- <mark>**Circuit Breaker**</mark>
 
<img src='images\img_41.png' alt='mtls' width='450'>

- <mark>**Traffic Splitting**</mark> 

<img src='images\img_42.png' alt='mtls' width='450'>

- <mark>**A/B Testing**</mark>

<img src='images\img_43.png' alt='mtls' width='600'>

- <mark>**Retry Logic**</mark>

<img src='images\img_44.png' alt='mtls' width='450'>

- <mark>**Fault Injections**</mark>

<img src='images\img_45.png' alt='mtls' width='450'>

- <mark>**Network Observability**</mark>

<img src='images\img_46.png' alt='mtls' width='450'>

---

#### Tools  
- **Istio**  
  - Installation ([Refer Here](https://istio.io/latest/docs/setup/install/helm/))  
  - Custom Resources:  
    - Virtual Service  
    - Destination Rules  
    - Gateway  
<img src='images\img_39.png' alt='service_mesh' width='400'>
### Control Plane Components:
1. **Pilot**  
   - **Role**: Responsible for service discovery, traffic management, and routing rules.  
   - **Functionality**:  
     - Configures proxies (Envoy) dynamically with routing rules and service discovery data.  
     - Supports advanced traffic control features like retries, timeouts, fault injection, and traffic mirroring.  

2. **Mixer** *(Deprecated in Istio 1.8 and removed in later versions)*  
   - **Role**: Handled policy enforcement and telemetry collection.  
   - **Functionality**:  
     - Allowed integration with external policy systems.  
     - Collected telemetry data (metrics, logs, traces) for monitoring and reporting.  
     - Was replaced by newer approaches like Envoy filters for telemetry and authorization.  

3. **Citadel** *(Merged into Istio Agent in later versions)*  
   - **Role**: Handled security-related tasks, such as certificate management for service-to-service communication.  
   - **Functionality**:  
     - Issued and rotated X.509 certificates for mTLS communication.  
     - Managed identity and authentication within the service mesh.

4. **Istiod**  
   - Introduced in later versions to unify the Istio control plane components.  
   - Combines the functionality of Pilot, Citadel, and Galley for simplified operations.

---

### Data Plane Component:
1. **Envoy**  
   - **Role**: The sidecar proxy deployed alongside application services.  
   - **Functionality**:  
     - Manages all inbound and outbound traffic for the services.  
     - Enforces security policies (e.g., mTLS).  
     - Collects telemetry data like metrics and traces.  
     - Implements traffic control rules from Pilot.

---

- **Linkerd**  
- **Istio on Azure** ([Refer Here](https://learn.microsoft.com/en-us/azure/aks/istio-about))  
- **Istio on AWS** ([Refer Here](https://aws.amazon.com/blogs/opensource/getting-started-with-istio-on-amazon-eks/))  

---

Istio is an open-source service mesh platform that provides traffic management, security, and observability for microservices.

### Key Features
1. **Traffic Management**:
   - Advanced routing: traffic splitting, mirroring, and retries.
   - Load balancing with multiple algorithms.
   - Fault injection for testing resilience.
2. **Security**:
   - Mutual TLS (mTLS) for secure service-to-service communication.
   - Role-Based Access Control (RBAC) and Authorization Policies.
3. **Observability**:
   - Distributed tracing with tools like Jaeger and Zipkin.
   - Metrics collection via Prometheus and visualization in Grafana.
   - Service dashboards using Kiali.
4. **Extensibility**:
   - WebAssembly (Wasm) for custom proxy filters.
   - Integration with external tools like Flagger for canary deployments.

### Architecture Components
- **Envoy Proxy**: Sidecar proxy deployed alongside each service.
- **Istiod**: Control plane managing configuration, certificates, and policies.
- **Ingress/Egress Gateway**: Controls external traffic entering and exiting the mesh.

### Installation Options
- **Istioctl**: Command-line tool for installation and management.
- **Helm Charts**: Customize installation using Helm.
- **Operator**: Use the Istio operator for lifecycle management.

### Deployment Examples
- Deploy Istio with default configurations:
  ```bash
  istioctl install --set profile=default
  ```
- Enable sidecar injection for a namespace:
  ```bash
  kubectl label namespace <namespace> istio-injection=enabled
  ```

### References
- Official Documentation: [istio.io](https://istio.io/)
- Installation Guide: [Istio Installation](https://istio.io/latest/docs/setup/)
- Traffic Management: [Traffic Management Guide](https://istio.io/latest/docs/tasks/traffic-management/)
- Security: [Security Features](https://istio.io/latest/docs/tasks/security/)
- Observability: [Observability Guide](https://istio.io/latest/docs/tasks/observability/)

---
---


# <mark>**istio yaml configuration examples**</mark>

Here are some popular workflows in Istio YAML configuration examples:

1. **Traffic Management with Virtual Service**:
   This example demonstrates how to route traffic between different versions of a service.

```
   yaml
   apiVersion: networking.istio.io/v1alpha3
   kind: VirtualService
   metadata:
     name: reviews
   spec:
     hosts:
       - reviews
     http:
       - route:
           - destination:
               name: reviews
               subset: v1
             weight: 90
           - destination:
               name: reviews
               subset: v2
             weight: 10
```

2. **Gateway Configuration**:
   This configuration allows external traffic to enter the service mesh.
```
   yaml
   apiVersion: networking.istio.io/v1alpha3
   kind: Gateway
   metadata:
     name: bookinfo-gateway
   spec:
     selector:
       istio: ingressgateway # use Istio's built-in gateway
     servers:
       - port:
           number: 80
           name: http
           protocol: HTTP
         hosts:
           - "*"
```  

3. **Service Entry for External Services**:
   This example shows how to define an external service that can be accessed from within the mesh.
```
   yaml
   apiVersion: networking.istio.io/v1alpha3
   kind: ServiceEntry
   metadata:
     name: my-external-service
   spec:
     hosts:
       - my.external.service.com
     ports:
       - number: 80
         name: http
         protocol: HTTP
     resolution: DNS
     endpoints:
       - address: my.external.service.com
```   

4. **Sidecar Configuration**:
   This configuration limits the outbound traffic from a specific service to only certain hosts.
```
   yaml
   apiVersion: networking.istio.io/v1alpha3
   kind: Sidecar
   metadata:
     name: my-sidecar-config
     namespace: default
   spec:
     egress:
       - hosts:
           - "./*"
           - "my-service/*"
```  

These configurations enable various functionalities like traffic routing, security, and observability in your microservices architecture using Istio.
---
splitting traffic istio complete process with example config

To split traffic using Istio, you need to configure two key resources: a *VirtualService* and a *DestinationRule*. Here’s a complete process with example configurations.

### Step 1: Define the DestinationRule

The *DestinationRule* specifies the subsets of your service that you want to route traffic to. For example, if you have two versions of a service, v1 and v2, you would define them as follows:
```
yaml
apiVersion: networking.istio.io/v1alpha3
kind: DestinationRule
metadata:
  name: my-service-destination
spec:
  host: my-service
  subsets:
    - name: v1
      labels:
        version: v1
    - name: v2
      labels:
        version: v2
```

### Step 2: Define the VirtualService

The *VirtualService* controls how requests are routed to the different subsets defined in the DestinationRule. Here’s an example that splits traffic between v1 and v2, sending 80% to v1 and 20% to v2:
```
yaml
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: my-service-virtualservice
spec:
  hosts:
    - my-service
  http:
    - route:
        - destination:
            host: my-service
            subset: v1
          weight: 80
        - destination:
            host: my-service
            subset: v2
          weight: 20
```

### Step 3: Apply the Configurations

Once you have defined your configurations in YAML files, apply them using kubectl:
```
bash
kubectl apply -f destination-rule.yaml
kubectl apply -f virtual-service.yaml
```

### Step 4: Verify Traffic Splitting

You can monitor the traffic distribution using tools like Kiali or by checking logs from your services. You should see that approximately 80% of requests go to version v1 and 20% to version v2.

This setup enables you to gradually roll out new features, perform canary deployments, or A/B testing effectively within your Istio service mesh
---