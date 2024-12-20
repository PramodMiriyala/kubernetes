service_account_info = {
  account_id   = "practice-service-account-01"
  display_name = "Service account"
  project      = "principal-truck-439009-a1"
}
container_cluster_info = {
  name                     = "my-gke-cluster"
  location                 = "asia-south1"
  zone                     = "asia-south1-a"
  remove_default_node_pool = true
  initial_node_count       = 1
}
container_node_pool_info = {
  name       = "my-node-pool"
  node_count = 1
  autoscaling = {
    min_node_count = 1
    max_node_count = 2

  }
  node_config = {
    preemptible  = true
    machine_type = "e2-medium"
  }
}