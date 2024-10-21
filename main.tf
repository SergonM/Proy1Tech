# main.tf



# Módulo VPC
module "vpc" {
  source           = "./modules/vpc"
  vpc_cidr         = var.vpc_cidr
  public_subnets   = var.public_subnets
  private_subnets  = var.private_subnets
  azs              = var.azs
}

# Módulo EKS
module "eks" {
  source                = "./modules/eks"
  cluster_name          = var.cluster_name
  cluster_version       = var.cluster_version
  vpc_id                = module.vpc.vpc_id
  private_subnets       = module.vpc.private_subnets
  public_subnets        = module.vpc.public_subnets
  node_instance_type    = var.node_instance_type
  desired_capacity      = var.desired_capacity
  max_size              = var.max_size
  min_size              = var.min_size
}

# Datos del clúster EKS para el proveedor de Kubernetes
data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_name

  depends_on = [
    module.eks  # Asegura que el clúster EKS se haya creado antes de intentar acceder a él
  ]
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_name

  depends_on = [
    module.eks  # Asegura que el clúster EKS se haya creado antes de intentar acceder a él
  ]
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}

# Módulo RDS
module "rds" {
  source                      = "./modules/rds"
  db_name                     = var.db_name
  db_username                 = var.db_username
  db_password                 = var.db_password
  vpc_id                      = module.vpc.vpc_id
  private_subnets             = module.vpc.private_subnets
  db_instance_class           = var.db_instance_class
  allocated_storage           = var.allocated_storage
  eks_node_security_group_id  = module.eks.worker_security_group_id
}

# Módulo Nginx
module "nginx" {
  source                   = "./modules/nginx"
  namespace                = "default"
  app_name                 = "nginx-app"
  replicas                 = 2
  vpc_id                   = module.vpc.vpc_id
  cluster_name             = module.eks.cluster_name
  cloudfront_cidr_blocks   = var.cloudfront_cidr_blocks
}

# Módulo CloudFront
module "cloudfront" {
  source                = "./modules/cloudfront"
  origin_dns            = module.nginx.nginx_service_hostname
}

# Módulo CodeDeploy
#module "codedeploy" {
#  source                = "./modules/codedeploy"
#  cluster_name          = module.eks.cluster_name
#  aws_region            = var.aws_region
#  service_name          = var.codedeploy_service_name
#}
