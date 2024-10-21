# modules/cloudfront/outputs.tf

output "cloudfront_domain_name" {
  description = "Nombre de dominio de CloudFront"
  value       = aws_cloudfront_distribution.this.domain_name
}
