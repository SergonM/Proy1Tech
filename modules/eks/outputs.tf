# modules/eks/outputs.tf

output "cluster_name" {
  description = "Nombre del clúster EKS"
  value       = aws_eks_cluster.this.name
}

output "cluster_endpoint" {
  description = "Endpoint del clúster EKS"
  value       = aws_eks_cluster.this.endpoint
}

output "cluster_certificate_authority" {
  description = "Autoridad certificadora del clúster EKS"
  value       = aws_eks_cluster.this.certificate_authority[0].data
}

output "worker_security_group_id" {
  value = aws_security_group.worker_sg.id
}
