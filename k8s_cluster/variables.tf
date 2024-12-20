variable "service_account_info" {
  type = object({
    account_id   = string
    display_name = string
    project      = string
  })
}

variable "container_cluster_info" {
  type = object({
    name                     = string
    location                 = string
    zone                     = string
    remove_default_node_pool = bool
    initial_node_count       = number
  })

  validation {
    condition     = var.container_cluster_info.initial_node_count > 0
    error_message = "initial_node_count must be greater than 0."
  }
}

variable "container_node_pool_info" {
  type = object({
    name       = string
    node_count = number
    autoscaling = object({
      min_node_count = number
      max_node_count = number
    })
    node_config = object({
      preemptible  = bool
      machine_type = string
    })
  })
}
