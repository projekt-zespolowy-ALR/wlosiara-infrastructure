# wlosiara-pl-infrastructure

## Pre-requisites
- Linux (tested on Manjaro) that will be used as a host machine
- Minikube
- Kubectl
- Helm
- NGINX setup on the host machine

## Setup
- Optionally, create a new user for the cluster using [./setup/create-user.sh](./setup/create-user.sh)
- Start minikube using [./setup/minikube/configure.sh](./setup/minikube/configure.sh)
- Note the IP address of the minikube cluster
- Setup NGINX to reverse proxy the incoming traffic to the cluster using [./setup/nginx/configure.sh](./setup/nginx/configure.sh). You need to provide the IP address of the minikube cluster as an environment variable `WLOSIARA_PL_MINIKUBE_CLUSTER_IP`.
- Setup Kubernetes secrets for the GitHub Actions runners using [./setup/kubernetes/configure.sh](./setup/kubernetes/configure.sh). You need to provide the base url of the exposed Kubernetes API as an environment variable `KUBERNETES_CLUSTER_API_BASE_URL`.
- Copy the KUBECONFIG which is outputted by the previous script to the GitHub Actions secrets as `KUBECONFIG`.
- The cluster is now ready to use, but for it to be completely functional, execute the `setup_cluster` GitHub Actions workflow located at [./.github/workflows/setup_cluster.yml](./.github/workflows/setup_cluster.yml). This will install self-hosted Docker registry and Helm chart repository on the cluster. Note that the workflow requires some secrets which you should provide in the GitHub Actions secrets.
