# modules/rds/variables.tf

variable "db_name" {
  description = "Nombre de la base de datos RDS"
  type        = string
}

variable "db_username" {
  description = "Nombre de usuario para RDS"
  type        = string
}

variable "db_password" {
  description = "Contraseña para RDS"
  type        = string
}

variable "db_instance_class" {
  description = "Clase de instancia para RDS"
  type        = string
}

variable "allocated_storage" {
  description = "Almacenamiento asignado para RDS (GB)"
  type        = number
}

variable "vpc_id" {
  description = "ID de la VPC"
  type        = string
}

variable "private_subnets" {
  description = "Lista de subnets privadas"
  type        = list(string)
}

variable "eks_node_security_group_id" {
  description = "ID del Security Group de los nodos EKS"
  type        = string
}
