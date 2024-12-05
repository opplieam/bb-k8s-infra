terraform {
  required_version = ">= 1.10"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.12.0"
    }
  }
  backend "gcs" {
    bucket = "tf-state-gke-be"
    prefix = "cluster-private"
  }
}

provider "google" {
  project = var.gcp_project
  region  = var.gcp_region
}
