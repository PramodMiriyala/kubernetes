resource "google_service_account" "base" {
  account_id   = var.service_account_info.account_id
  display_name = var.service_account_info.display_name
}

resource "google_container_cluster" "base" {
  name                     = var.container_cluster_info.name
  location                 = var.container_cluster_info.location
  remove_default_node_pool = var.container_cluster_info.remove_default_node_pool
  initial_node_count       = var.container_cluster_info.initial_node_count
  deletion_protection      = false
  resource_labels = {
    environment = "dev"
    team        = "ops"
  }
}

resource "google_container_node_pool" "base" {
  name       = var.container_node_pool_info.name
  location   = var.container_cluster_info.location
  cluster    = google_container_cluster.base.name
  node_count = var.container_node_pool_info.node_count

  autoscaling {
    min_node_count = var.container_node_pool_info.autoscaling.min_node_count
    max_node_count = var.container_node_pool_info.autoscaling.max_node_count
  }

  node_config {
    preemptible  = var.container_node_pool_info.node_config.preemptible
    machine_type = var.container_node_pool_info.node_config.machine_type

    service_account = google_service_account.base.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}

resource "google_project_iam_member" "service_account_roles" {
  project = var.service_account_info.project
  role    = "roles/container.nodeServiceAccount"
  member  = "serviceAccount:${google_service_account.base.email}"
}
