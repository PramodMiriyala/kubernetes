
## **K8s Installation (Self-hosted)**

### **Lab Setup**
- **Nodes**: 3 Ubuntu 22.04 machines
- Ensure they can reach each other over the network.

### **Installation Overview**:
1. Install **Docker** on all nodes.
2. Install **CRI-dockerd** on all nodes.
3. Install **kubeadm**, **kubectl**, and **kubelet** on all nodes.
4. Initialize the cluster on the **master node**. This will generate a join command to be executed on worker nodes.
5. Configure **kubectl** on the master node.
6. For **pod networking**, install **CNI-Plugins**.
7. Install **Flannel CNI Plugins** for networking between pods.

Refer to the official documentation for kubeadm installation:  
[Install Kubeadm](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/)

### **Installing Docker**:

```bash
#!/bin/bash
curl -fsSL https://get.docker.com -o install-docker.sh
sh install-docker.sh
```

### **Installing CRI-dockerd**:
Refer to the [CRI-dockerd Releases](https://github.com/Mirantis/cri-dockerd/releases) for the latest versions.

```bash
cd /tmp
wget https://github.com/Mirantis/cri-dockerd/releases/download/v0.3.15/cri-dockerd_0.3.15.3-0.ubuntu-jammy_amd64.deb
sudo dpkg -i cri-dockerd_0.3.15.3-0.ubuntu-jammy_amd64.deb
```

### **Install Kubeadm, Kubectl, and Kubelet**:
Refer to the [official guide](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/#installing-kubeadm-kubelet-and-kubectl).

```bash
# Update the package index
sudo apt-get update 

# Install packages for adding a repository
sudo apt-get install -y apt-transport-https ca-certificates curl gpg 

# Add the Kubernetes GPG key
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.31/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg 

# Add the Kubernetes APT repository
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.31/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list 

# Update package index again
sudo apt-get update 

# Install Kubernetes components: kubelet, kubeadm, kubectl
sudo apt-get install -y kubelet kubeadm kubectl 

# Hold the packages at the current version
sudo apt-mark hold kubelet kubeadm kubectl 

# Enable and start the kubelet service
sudo systemctl enable --now kubelet 
```

### **Initialize Kubernetes Cluster on Master Node**:
Refer to the [Kubernetes Create Cluster with Kubeadm](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/).

```bash
# Initialize the cluster
kubeadm init --pod-network-cidr=10.244.0.0/16 --cri-socket "unix:///var/run/cri-dockerd.sock"
```

Save the **join command** provided after the initialization.

![image](images\img_07.png)

### **Configure kubectl on Master Node**:

![image](images\img_08.png)

After cluster initialization, switch to a normal user and configure **kubectl**.


```bash
# Copy kubeconfig to user directory
mkdir -p $HOME/.kube
cp -i /etc/kubernetes/admin.conf $HOME/.kube/config

# Set appropriate permissions
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```

### **Join Worker Nodes**:
On each worker node, execute the **join command** provided by the master node:

```bash
kubeadm join <master-ip>:6443 --token <token> --discovery-token-ca-cert-hash sha256:<hash> --cri-socket "unix:///var/run/cri-dockerd.sock"
```

### **Check Node Status**:
On the master node, verify node status:

```bash
kubectl get nodes
```

![image](images\img_09.png)

If nodes show a "NotReady" status, install the **Flannel CNI plugin** to enable networking between pods.

### **Install Flannel CNI Plugin**:
On the master node, apply the Flannel CNI plugin YAML file:

```bash
kubectl apply -f https://github.com/coreos/flannel/raw/master/Documentation/kube-flannel.yml
```
![image](images\img_10.png)
### **K8s Interfaces**:
- **CRI (Container Runtime Interface)**
- **CNI (Container Network Interface)**
- **CSI (Container Storage Interface)**

--- 
---
### **auto-completion in PowerShell**

To set up `kubectl` auto-completion in PowerShell, follow these steps:

1. **Enable `kubectl` Auto-Completion Script**:  
   Run the following command to generate the script and add it to your profile:
   ```powershell
   kubectl completion powershell | Out-String | Set-Content -Path $PROFILE
   ```

2. **Reload Your Profile**:  
   Apply the changes by reloading your PowerShell profile:
   ```powershell
   . $PROFILE
   ```

3. **Check Alias Support (Optional)**:  
   If you use an alias (e.g., `k` for `kubectl`), register auto-completion for the alias:
   ```powershell
   Set-Alias -Name k -Value kubectl
   kubectl completion powershell | Out-String | Invoke-Expression
   ```

After these steps, `kubectl` commands should support auto-completion in PowerShell. Let me know if you encounter issues!

### **alias for `kubectl`**
The alias for `kubectl` might not work with the PowerShell argument completer because `Register-ArgumentCompleter` binds directly to the command name (`kubectl` in this case), not to its alias.

### Resolution:
To make autocompletion work with the alias:

1. **Set Up the Alias in PowerShell:**
   Ensure the alias is defined, for example:
   ```powershell
   Set-Alias -Name k -Value kubectl
   ```

2. **Register the Completer for the Alias:**
   Update the `Register-ArgumentCompleter` command to bind the completer to the alias (`k`) as well:
   ```powershell
   Register-ArgumentCompleter -CommandName 'kubectl', 'k' -ScriptBlock $__kubectlCompleterBlock
   ```

3. **Reload PowerShell or Profile Script:**
   If the script for argument completion is part of your PowerShell profile, reload the profile:
   ```powershell
   . $PROFILE
   ```

This ensures that both the original command and its alias are linked to the completion logic. Let me know if further assistance is needed!