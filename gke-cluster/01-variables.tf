# GCP Project
variable "gcp_project" {
  description = "Project in which GCP Resources to be created"
  type        = string
}

# GCP Region
variable "gcp_region" {
  description = "Region in which GCP Resources to be created"
  type        = string
}

variable "environment" {
  description = "Environment in which GCP Resources to be created"
  type        = string
  default     = "dev"
}

# GCP Compute Engine Machine Type
variable "machine_type" {
  description = "Compute Engine Machine Type"
  type        = string
  default     = "e2-micro"
}

# CIDR IP Ranges
variable "subnet_ip_range" {
  description = "Subnet IP range"
  type        = string
  default     = "10.129.0.0/20"
}

variable "pods_ip_range" {
  description = "Kubernetes Pods IP range"
  type        = string
  default     = "10.11.0.0/21"
}

variable "services_ip_range" {
  description = "Kubernetes Services IP range"
  type        = string
  default     = "10.12.0.0/21"
}

variable "master_ip_range" {
  description = "Kubernetes Master IP range"
  type        = string
  default     = "10.13.0.0/28"
}

locals {
  name = "${var.gcp_project}-${var.environment}"
}
