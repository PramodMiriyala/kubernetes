terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.13.0"
    }
  }
}

provider "google" {
  # Configuration options
  project = var.service_account_info.project
  region  = var.container_cluster_info.location
  zone    = var.container_cluster_info.zone
}