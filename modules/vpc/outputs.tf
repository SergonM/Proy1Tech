# modules/vpc/outputs.tf

output "vpc_id" {
  description = "ID de la VPC"
  value       = aws_vpc.this.id
}

output "public_subnets" {
  description = "Lista de subnets públicas"
  value       = aws_subnet.public[*].id
}

output "private_subnets" {
  description = "Lista de subnets privadas"
  value       = aws_subnet.private[*].id
}
