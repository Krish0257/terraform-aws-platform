###############################################
# VPC
###############################################

module "vpc" {
  source = "../../modules/vpc"

  project_name = var.project_name
  environment  = var.environment

  aws_region = "ap-south-1"

  network = var.network

  nat_gateway = var.nat_gateway

  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
  instance_tenancy     = var.instance_tenancy

  common_tags = var.common_tags
}

###############################################
# IAM
###############################################

module "iam" {
  source = "../../modules/iam"

  name_prefix = "${var.project_name}-${var.environment}"

  tags = merge(
    var.common_tags,
    {
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "Terraform"
    }
  )
}


###############################################
# EKS
###############################################

module "eks" {
  source = "../../modules/eks"

  cluster_name = "${var.project_name}-${var.environment}-eks"

  vpc_id = module.vpc.vpc_id

  private_subnet_ids = values(module.vpc.private_subnet_ids)

  cluster_role_arn = module.iam.eks_cluster_role_arn
  node_role_arn    = module.iam.eks_node_group_role_arn

  depends_on = [
    module.vpc,
    module.iam
  ]
}

################################ ECR #################################3

###############################################
# ECR
###############################################

module "ecr" {
  source = "../../modules/ecr"

  repository_name = "${var.project_name}-app"

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project_name}-ecr"
      Environment = var.environment
      ManagedBy   = "Terraform"
    }
  )

  depends_on = [
    module.eks
  ]
}

###############################################
# GitHub OIDC
###############################################

module "github_oidc" {
  source = "../../modules/github-oidc"

  github_organization = "Krish0257"

  github_repository = "terraform-aws-platform"

  role_name = "github-actions-oidc"

  branch = "main"

  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser",
    "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  ]

  tags = merge(
    var.common_tags,
    {
      Name        = "github-actions-oidc"
      Environment = var.environment
      ManagedBy   = "Terraform"
    }
  )

  depends_on = [
    module.ecr,
    module.eks
  ]
}

###############################################
# EKS Add-ons
###############################################

module "addons" {
  source = "../../modules/addons"

  cluster_name    = module.eks.cluster_name
  cluster_version = module.eks.cluster_version

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project_name}-addons"
      Environment = var.environment
      ManagedBy   = "Terraform"
    }
  )

  depends_on = [
    module.eks
  ]
}


###############################################
# NGINX Ingress Controller
###############################################

module "ingress_nginx" {
  source = "../../modules/ingress-nginx"

  namespace        = "ingress-nginx"
  create_namespace = true

  release_name = "ingress-nginx"

  chart_version = "4.12.3"

  values_files = []

  timeout = 900
  wait    = true

  atomic          = true
  cleanup_on_fail = true

  dependency_update = true

  tags = merge(
    var.common_tags,
    {
      Name        = "ingress-nginx"
      Environment = var.environment
      ManagedBy   = "Terraform"
    }
  )

  depends_on = [
    module.addons
  ]
}