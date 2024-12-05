resource "google_compute_network" "bb_vpc" {
  name                    = "${local.name}-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "bb_subnet" {
  name                     = "${local.name}-${var.gcp_region}-subnet"
  region                   = var.gcp_region
  network                  = google_compute_network.bb_vpc.id
  private_ip_google_access = true
  ip_cidr_range            = var.subnet_ip_range
  secondary_ip_range {
    range_name    = "kubernetes-pod-range"
    ip_cidr_range = var.pods_ip_range
  }
  secondary_ip_range {
    range_name    = "kubernetes-services-range"
    ip_cidr_range = var.services_ip_range
  }
}
