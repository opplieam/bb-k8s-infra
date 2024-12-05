# Resource: GKE Cluster
resource "google_container_cluster" "gke_cluster" {
  name     = "${local.name}-gke-cluster"
  location = var.gcp_region

  node_locations = ["us-east1-b", "us-east1-c", "us-east1-d"]

  # Create the smallest possible default node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1

  # Network
  network    = google_compute_network.bb_vpc.self_link
  subnetwork = google_compute_subnetwork.bb_subnet.self_link

  # In production, change it to true (Enable it to avoid accidental deletion)
  deletion_protection = var.environment == "dev" ? false : true

  # Private Cluster Configurations
  private_cluster_config {
    enable_private_endpoint = false
    enable_private_nodes    = true
    master_ipv4_cidr_block  = var.master_ip_range
  }

  # IP Address Ranges
  ip_allocation_policy {
    cluster_secondary_range_name  = google_compute_subnetwork.bb_subnet.secondary_ip_range[0].range_name
    services_secondary_range_name = google_compute_subnetwork.bb_subnet.secondary_ip_range[1].range_name
  }

  # Allow access to Kubernetes master API Endpoint
  master_authorized_networks_config {
    cidr_blocks {
      cidr_block   = "0.0.0.0/0"
      display_name = "All CIDR Ranges"
    }
  }
}

output "gke_cluster_name" {
  description = "GKE cluster name"
  value       = google_container_cluster.gke_cluster.name
}

output "gke_cluster_location" {
  description = "GKE Cluster location"
  value       = google_container_cluster.gke_cluster.location
}

output "gke_cluster_endpoint" {
  description = "GKE Cluster Endpoint"
  value       = google_container_cluster.gke_cluster.endpoint
}

output "gke_cluster_master_version" {
  description = "GKE Cluster master version"
  value       = google_container_cluster.gke_cluster.master_version
}
