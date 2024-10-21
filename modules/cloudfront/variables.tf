# modules/cloudfront/variables.tf

variable "origin_dns" {
  description = "DNS del origen (balanceador de carga de Nginx)"
  type        = string
}
