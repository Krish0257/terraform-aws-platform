# Terraform AWS Platform

> Enterprise-grade AWS Kubernetes Platform provisioned using Terraform.

![Terraform](https://img.shields.io/badge/Terraform-1.8+-623CE4?logo=terraform)
![AWS](https://img.shields.io/badge/AWS-EKS-FF9900?logo=amazonaws)
![Kubernetes](https://img.shields.io/badge/Kubernetes-v1.34-326CE5?logo=kubernetes)
![ArgoCD](https://img.shields.io/badge/GitOps-ArgoCD-EF7B4D)
![License](https://img.shields.io/badge/License-MIT-green)

---

## Overview

This repository provisions a complete **enterprise-ready Kubernetes platform on AWS** using Terraform.

The platform includes networking, IAM, Amazon EKS, monitoring, ingress, GitOps, and progressive delivery components that serve as the foundation for deploying cloud-native applications.

The infrastructure is modular, reusable, and follows Infrastructure as Code (IaC) best practices.

---

# Architecture

![AWS Platform Architecture](docs/screenshots/aws-platform-architecture.png)

---

# Platform Components

The platform provisions the following components:

### AWS Infrastructure

- Amazon VPC
- Public & Private Subnets
- Internet Gateway
- NAT Gateway
- Route Tables
- Security Groups
- IAM Roles & Policies
- Amazon EKS Cluster
- Managed Node Groups
- Amazon ECR

### Kubernetes Platform

- NGINX Ingress Controller
- ArgoCD
- Argo Rollouts
- Prometheus
- Grafana
- Alertmanager
- Metrics Server

---

# Architecture Stack

```
Terraform
        │
        ▼
AWS Infrastructure
        │
        ├── VPC
        ├── IAM
        ├── Networking
        ├── Amazon EKS
        └── Managed Node Groups
                │
                ▼
Kubernetes Platform
        │
        ├── NGINX Ingress
        ├── Prometheus
        ├── Grafana
        ├── ArgoCD
        ├── Argo Rollouts
        └── Metrics Server
```

---

# Repository Structure

```
terraform-aws-platform/

├── docs/
│   └── screenshots/
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
└── README.md
```

---

# Terraform Modules

| Module | Description |
|----------|-------------|
| vpc | Creates AWS networking infrastructure |
| iam | Creates IAM roles and policies |
| eks | Provisions Amazon EKS cluster |
| ecr | Creates Amazon ECR repositories |
| github-oidc | Configures GitHub OIDC authentication |
| ingress-nginx | Installs NGINX Ingress Controller |
| prometheus-grafana | Deploys Prometheus & Grafana |
| argocd | Installs ArgoCD |
| argo-rollouts | Installs Argo Rollouts |
| addons | Kubernetes platform add-ons |

---

# Technology Stack

| Category | Technology |
|-----------|------------|
| Infrastructure as Code | Terraform |
| Cloud Provider | AWS |
| Container Orchestration | Amazon EKS |
| Networking | VPC |
| Container Registry | Amazon ECR |
| GitOps | ArgoCD |
| Progressive Delivery | Argo Rollouts |
| Monitoring | Prometheus |
| Visualization | Grafana |
| Ingress | NGINX Ingress Controller |

---

# Prerequisites

- AWS Account
- AWS CLI
- Terraform 1.8+
- kubectl
- Helm
- Git

---

# Deployment

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

# Verify Cluster

Configure kubeconfig:

```bash
aws eks update-kubeconfig \
--region <region> \
--name <cluster-name>
```

Verify nodes:

```bash
kubectl get nodes
```

---

# Verify Platform Components

```bash
kubectl get pods -A
```

Expected namespaces:

- kube-system
- ingress-nginx
- monitoring
- argocd
- argo-rollouts

---

# Platform Services

Verify Ingress Controller

```bash
kubectl get pods -n ingress-nginx
```

Verify Monitoring Stack

```bash
kubectl get pods -n monitoring
```

Verify ArgoCD

```bash
kubectl get pods -n argocd
```

Verify Argo Rollouts

```bash
kubectl get pods -n argo-rollouts
```

---

# Screenshots

## AWS Platform Architecture

![Architecture](docs/screenshots/aws-platform-architecture.png)

---

## Terraform Module Architecture

![Modules](docs/screenshots/terraform-modules.png)

---

## Kubernetes Platform Services

![Platform](docs/screenshots/kubernetes-platform-services.png)

---

## Platform Provisioning Flow

![Provisioning](docs/screenshots/platform-provisioning-flow.png)

---

# Features

- Modular Terraform Architecture
- Reusable Infrastructure Modules
- Amazon EKS
- Enterprise Networking
- IAM Best Practices
- GitHub OIDC Support
- Kubernetes Platform Automation
- GitOps Ready
- Progressive Delivery Ready
- Observability Platform
- Infrastructure as Code

---

# Future Enhancements

- AWS Load Balancer Controller
- ExternalDNS
- Cluster Autoscaler
- Karpenter
- Velero Backup
- Loki
- Tempo
- Thanos
- Multi-Environment Support
- Multi-Cluster Support

---

# Related Repository

**Application Repository**

➡️ **flask-rollouts-demo**

Demonstrates GitOps, CI/CD, Canary Deployments, Automated Analysis, and Rollbacks using the platform created by this repository.

---

# Author

**Murali Krishna**

Cloud & DevOps Engineer

**Skills**

AWS • Terraform • Kubernetes • Amazon EKS • ArgoCD • Argo Rollouts • Prometheus • Grafana • GitHub Actions • Docker

---

## License

This project is licensed under the MIT License.