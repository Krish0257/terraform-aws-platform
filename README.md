# 🚀 Terraform AWS Platform

> Enterprise-grade AWS infrastructure and Kubernetes platform provisioning using Terraform.

![Terraform](https://img.shields.io/badge/Terraform-1.8+-623CE4?logo=terraform)
![AWS](https://img.shields.io/badge/AWS-EKS-FF9900?logo=amazonaws)
![Kubernetes](https://img.shields.io/badge/Kubernetes-v1.34-326CE5?logo=kubernetes)
![License](https://img.shields.io/badge/License-MIT-green)

---

# 📖 Overview

**terraform-aws-platform** provisions a complete production-style Kubernetes platform on AWS using Terraform.

The platform serves as the foundation for deploying cloud-native applications by provisioning networking, IAM, Amazon EKS, ingress, monitoring, GitOps, and progressive delivery components.

This repository focuses only on **platform provisioning**.

Application deployment is maintained in a separate repository.

---

# 🏗️ AWS Platform Architecture

<p align="center">
<img src="docs/screenshots/Aws.png" width="100%">
</p>

---

# ⚙️ Platform Components

## AWS Infrastructure

- Amazon VPC
- Internet Gateway
- Public Subnets
- Private Subnets
- NAT Gateway
- Route Tables
- Security Groups
- IAM Roles & Policies
- Amazon EKS Cluster
- Managed Node Groups
- Amazon ECR

---

## Kubernetes Platform

- NGINX Ingress Controller
- Prometheus
- Grafana
- Alertmanager
- Metrics Server
- ArgoCD
- Argo Rollouts

---

# 🧱 Terraform Module Architecture

<p align="center">
<img src="docs/screenshots/Terraform module_architecture.png" width="100%">
</p>

---

# ☸️ Kubernetes Platform Services

<p align="center">
<img src="docs/screenshots/Kubernetes platform service.png" width="100%">
</p>

---

# 🚀 Platform Provisioning Workflow

<p align="center">
<img src="docs/screenshots/Terraform platform provisioning.png" width="100%">
</p>

---

# 📂 Repository Structure

```text
terraform-aws-platform/

├── docs/
│   └── screenshots/
│       ├── Aws.png
│       ├── Kubernetes platform service.png
│       ├── Terraform module_architecture.png
│       └── Terraform platform provisioning.png
│
├── environments/
│   ├── dev/
│   └── platform/
│
├── modules/
│   ├── addons/
│   ├── argo-rollouts/
│   ├── argocd/
│   ├── ecr/
│   ├── eks/
│   ├── github-oidc/
│   ├── iam/
│   ├── ingress-nginx/
│   ├── prometheus-grafana/
│   └── vpc/
│
├── .gitignore
├── LICENSE
└── README.md
```

---

# 📦 Terraform Modules

| Module | Purpose |
|----------|----------|
| VPC | Creates AWS networking resources |
| IAM | Creates IAM Roles & Policies |
| EKS | Provisions Amazon EKS Cluster |
| ECR | Creates Amazon ECR Repository |
| GitHub OIDC | GitHub authentication using OIDC |
| Ingress NGINX | Deploys NGINX Ingress Controller |
| Prometheus-Grafana | Monitoring & Observability |
| ArgoCD | GitOps Platform |
| Argo Rollouts | Progressive Delivery |
| Addons | Common Kubernetes add-ons |

---

# 🛠️ Technology Stack

| Category | Technology |
|-----------|------------|
| Infrastructure as Code | Terraform |
| Cloud Platform | AWS |
| Kubernetes | Amazon EKS |
| Container Registry | Amazon ECR |
| GitOps | ArgoCD |
| Progressive Delivery | Argo Rollouts |
| Monitoring | Prometheus |
| Dashboards | Grafana |
| Ingress | NGINX Ingress Controller |

---

# 📋 Prerequisites

- AWS Account
- AWS CLI
- Terraform >= 1.8
- kubectl
- Helm
- Git

---

# 🚀 Deployment

## Clone Repository

```bash
git clone https://github.com/<your-username>/terraform-aws-platform.git

cd terraform-aws-platform
```

---

## Initialize Terraform

```bash
terraform init
```

---

## Validate Configuration

```bash
terraform validate
```

---

## Review Execution Plan

```bash
terraform plan
```

---

## Provision Infrastructure

```bash
terraform apply
```

---

# 🔍 Verify Cluster

Configure kubeconfig

```bash
aws eks update-kubeconfig \
--region <region> \
--name <cluster-name>
```

Verify Worker Nodes

```bash
kubectl get nodes
```

---

# 🔎 Verify Platform

Check Platform Components

```bash
kubectl get pods -A
```

Expected Namespaces

- kube-system
- ingress-nginx
- monitoring
- argocd
- argo-rollouts

---

# ✨ Features

- Enterprise Modular Terraform Design
- AWS Well-Architected Principles
- Amazon EKS
- Production Networking
- GitHub OIDC Authentication
- Kubernetes Platform Automation
- GitOps Ready
- Progressive Delivery Ready
- Monitoring & Observability
- Infrastructure as Code
- Reusable Terraform Modules

---

# 🔮 Future Enhancements

- AWS Load Balancer Controller
- ExternalDNS
- Karpenter
- Cluster Autoscaler
- Velero
- Loki
- Tempo
- Thanos
- Multi-Environment Support
- Multi-Cluster Deployment

---

# 🔗 Related Repository

### Application Repository

**flask-rollouts-demo**

Demonstrates:

- GitHub Actions CI/CD
- Docker
- Amazon ECR
- Helm
- ArgoCD
- Argo Rollouts
- Canary Deployment
- Automated Rollback
- Prometheus Metrics
- Grafana Dashboards

Built on top of this platform repository.

---

# 👨‍💻 Author

**Murali Krishna**

Cloud & DevOps Engineer

**Skills**

AWS • Terraform • Kubernetes • Amazon EKS • ArgoCD • Argo Rollouts • Prometheus • Grafana • Docker • GitHub Actions

---

# 📄 License

Licensed under the MIT License.