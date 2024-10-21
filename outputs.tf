# outputs.tf

output "vpc_id" {
  description = "ID de la VPC"
  value       = module.vpc.vpc_id
}

output "eks_cluster_name" {
  description = "Nombre del clúster EKS"
  value       = module.eks.cluster_name
}

output "rds_endpoint" {
  description = "Endpoint de la base de datos RDS"
  value       = module.rds.db_endpoint
}

output "cloudfront_domain_name" {
  description = "Nombre de dominio de CloudFront"
  value       = module.cloudfront.cloudfront_domain_name
}
