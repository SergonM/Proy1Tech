# modules/nginx/outputs.tf

output "nginx_service_hostname" {
  description = "Hostname del Load Balancer de Nginx"
  value       = kubernetes_service.nginx.status[0].load_balancer[0].ingress[0].hostname
}
