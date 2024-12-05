resource "google_container_node_pool" "linux_nodepool" {
  name               = "${local.name}-linux-nodepool"
  location           = var.gcp_region
  cluster            = google_container_cluster.gke_cluster.name
  initial_node_count = 1 # the number of nodes to create in each zone
  autoscaling {
    min_node_count  = 1
    max_node_count  = 4
    location_policy = "ANY"
  }
  node_config {
    preemptible  = true
    machine_type = var.machine_type

    service_account = google_service_account.gke_sa.email

    disk_size_gb = 10
    disk_type    = "pd-standard"
  }
}

output "gke_linux_nodepool_id" {
  description = "GKE Linux Node Pool ID"
  value       = google_container_node_pool.linux_nodepool.id
}
output "gke_linux_nodepool_version" {
  description = "GKE Linux Node Pool version"
  value       = google_container_node_pool.linux_nodepool.version
}

