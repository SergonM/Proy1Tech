# modules/eks/variables.tf

variable "cluster_name" {
  description = "Nombre del clúster EKS"
  type        = string
}

variable "cluster_version" {
  description = "Versión de Kubernetes para EKS"
  type        = string
  default     = "1.21"
}

variable "vpc_id" {
  description = "ID de la VPC"
  type        = string
}

variable "private_subnets" {
  description = "Lista de subnets privadas"
  type        = list(string)
}

variable "public_subnets" {
  description = "Lista de subnets públicas"
  type        = list(string)
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

variable "worker_node_instance_type" {
  description = "EC2 instance type for worker nodes"
  type        = string
  default     = "t3.medium"
}
