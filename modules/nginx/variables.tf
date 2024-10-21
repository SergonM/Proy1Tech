# modules/nginx/variables.tf

variable "namespace" {
  description = "Namespace en Kubernetes donde se desplegará Nginx"
  type        = string
  default     = "default"
}

variable "app_name" {
  description = "Nombre de la aplicación Nginx"
  type        = string
}

variable "replicas" {
  description = "Número de réplicas de Nginx"
  type        = number
  default     = 2
}

variable "vpc_id" {
  description = "ID de la VPC"
  type        = string
}

variable "cluster_name" {
  description = "Nombre del clúster EKS"
  type        = string
}

variable "cloudfront_cidr_blocks" {
  description = "Lista de CIDR blocks de CloudFront"
  type        = list(string)
}
