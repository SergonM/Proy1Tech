# terraform.tfvars

aws_region       = "us-east-1"
vpc_cidr         = "10.0.0.0/16"
public_subnets   = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnets  = ["10.0.3.0/24", "10.0.4.0/24"]
azs              = ["us-east-1a", "us-east-1b"]

cluster_name     = "cloudapp-eks-cluster"

db_name          = "cloudappdb"
db_username      = "admin"
db_password      = "your-secure-password"  # Reemplazar con una contraseña segura o gestionar con AWS Secrets Manager

codedeploy_service_name = "nginx-app"
