# Buy Better Kubernetes Infrastructure

### Centralized Kubernetes Resource Repository

This repository serves as a centralized hub for Kubernetes resource files (YAML) and Terraform Infrastructure as Code (IaC) for Google Kubernetes Engine (GKE). It leverages ArgoCD to monitor, synchronize, and deploy these resources to the Kubernetes cluster.

### Automated Resource Management

All Kubernetes resource files are automatically generated and managed through a CI/CD pipeline:

- **Code Changes:** When a pull request for a service (e.g., `bb-core-api`) is merged, GitHub Actions triggers a build and pushes the new image to Docker Hub.
- **Helm Chart Generation:** Helm generates updated YAML files with the specific image tag and commits them to this repository.
- **ArgoCD Deployment:** ArgoCD detects the changes and automatically deploys the updated resources to the Kubernetes cluster.

### Infrastructure as Code (IaC) with Terraform

This repository also includes Terraform IaC for provisioning and managing the GKE cluster, including:

- Networking configuration
- Static IP for Ingress
- Router and NAT
- Service Account and Roles

### Certificate Management with Certificate Manager

To ensure secure communication within the cluster, Certificate Manager is utilized to automate the issuance, rotation, and management of SSL/TLS certificates.

[Example of GitHub Actions that push files to this repository.](https://github.com/opplieam/bb-core-api/blob/main/.github/workflows/ci.yml)

### CI/CD Pipeline

![img](https://github.com/opplieam/bb-k8s-infra/blob/main/k8s.drawio.png?raw=true)

### ArgoCD Screenshot

![img](https://github.com/opplieam/bb-k8s-infra/blob/main/argocd-ss.png?raw=true)
