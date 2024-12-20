# Output Values for Usability
output "service_account_email" {
  value       = google_service_account.base.email
  description = "The email of the created service account."
}

output "cluster_endpoint" {
  value       = google_container_cluster.base.endpoint 
  description = "The endpoint of the GKE cluster."
}

output "node_pool_name" {
  value       = google_container_node_pool.base.name 
  description = "The name of the created node pool."
}