# Buy Better Kubernetes Infrastructure

This repository is designed to serve as a centralized location for Kubernetes resources (YAML files). It utilizes `ArgoCD` to monitor and synchronize resources within the Kubernetes cluster. All resource files are generated from the original service repository.

For example, in the case of `bb-core-api`: after a pull request is merged, `GitHub Actions` will build and push the images to Docker Hub. Subsequently, `Helm` will generate the YAML files with the specific image tag, which will then be pushed to this repository. `ArgoCD` will manage the deployment to the Kubernetes cluster.

### CI/CD Pipeline

![img](https://github.com/opplieam/bb-k8s-infra/blob/main/k8s.drawio.png?raw=true)

### ArgoCD Screenshot

![img](https://github.com/opplieam/bb-k8s-infra/blob/main/argocd-ss.png?raw=true)
