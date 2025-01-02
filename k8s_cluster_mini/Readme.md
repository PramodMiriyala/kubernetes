To connect to your GKE cluster, you can use the Google Cloud CLI (`gcloud`) to configure your local environment and interact with the cluster.

### Steps to Connect:
1. **Authenticate with `gcloud`:**
   Make sure you are authenticated with Google Cloud:
   ```bash
   gcloud auth login
   ```

2. **Set the Active Project:**
   Set the project associated with your GKE cluster:
   ```bash
   gcloud config set project <project-id>
   ```
   Replace `<project-id>` with your project ID, e.g., `principal-truck-439009-a1`.

3. **Configure `kubectl` for the Cluster:**
   Fetch the cluster credentials using the endpoint or cluster name:
   ```bash
   gcloud container clusters get-credentials my-gke-cluster --region asia-south1
   ```
   Replace `my-gke-cluster` and `asia-south1` with your actual cluster name and location.

   This command sets up your local `kubectl` configuration to use the correct authentication and endpoint (`34.47.359.220`).

4. **Verify Connection:**
   Test your connection to the cluster:
   ```bash
   kubectl get nodes
   ```
   This should display the nodes in the cluster, including the node pool (`my-node-pool`).

---

### Additional Notes:
- **Ensure You Have `kubectl` Installed:**
  If `kubectl` is not already installed, you can install it via the Google Cloud SDK:
  ```bash
  gcloud components install kubectl
  ```

- **IAM Permissions:**
  The Google Cloud user or service account you are using must have the required permissions, such as `roles/container.admin` or similar, to fetch credentials and interact with the cluster.

This setup will let you manage your GKE cluster and node pools using `kubectl` and the provided endpoint.
