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