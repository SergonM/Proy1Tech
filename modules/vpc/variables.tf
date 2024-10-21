# modules/vpc/variables.tf

variable "vpc_cidr" {
  description = "CIDR para la VPC"
  type        = string
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
