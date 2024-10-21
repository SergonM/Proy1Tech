# modules/rds/outputs.tf

output "db_endpoint" {
  description = "Endpoint de la base de datos RDS"
  value       = aws_db_instance.this.address
}

output "db_port" {
  description = "Puerto de la base de datos RDS"
  value       = aws_db_instance.this.port
}
