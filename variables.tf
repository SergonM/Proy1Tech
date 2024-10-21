# variables.tf

variable "aws_region" {
  description = "Región de AWS"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "CIDR para la VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "Lista de CIDRs para las subredes públicas"
  type        = list(string)
}

variable "private_subnets" {
  description = "Lista de CIDRs para las subredes privadas"
  type        = list(string)
}

variable "azs" {
  description = "Lista de zonas de disponibilidad"
  type        = list(string)
}

variable "cluster_name" {
  description = "Nombre del clúster EKS"
  type        = string
}

variable "cluster_version" {
  description = "Versión de Kubernetes para EKS"
  type        = string
  default     = "1.26"
}

variable "node_instance_type" {
  description = "Tipo de instancia para los nodos EKS"
  type        = string
  default     = "t3.medium"
}

variable "desired_capacity" {
  description = "Capacidad deseada del grupo de nodos"
  type        = number
  default     = 2
}

variable "max_size" {
  description = "Tamaño máximo del grupo de nodos"
  type        = number
  default     = 4
}

variable "min_size" {
  description = "Tamaño mínimo del grupo de nodos"
  type        = number
  default     = 2
}

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
  default     = "db.t3.medium"
}

variable "allocated_storage" {
  description = "Almacenamiento asignado para RDS (GB)"
  type        = number
  default     = 20
}

variable "cloudfront_cidr_blocks" {
  description = "Lista de CIDR blocks de CloudFront"
  type        = list(string)
  default     = [
    # Lista parcial de rangos IP de CloudFront (se recomienda obtener la lista completa de AWS)
    "13.32.0.0/15",
    "13.35.0.0/16",
    "13.54.63.128/26",
    "13.59.250.0/26",
    # Agregar todos los rangos según documentación de AWS
  ]
}

variable "codedeploy_service_name" {
  description = "Nombre del servicio para CodeDeploy"
  type        = string
  default     = "nginx-app"
}
