# modules/nginx/main.tf

# Security Group para el Load Balancer de Nginx
resource "aws_security_group" "lb_sg" {
  name        = "${var.cluster_name}-lb-sg"
  description = "Security Group para el Load Balancer de Nginx"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    cidr_blocks     = var.cloudfront_cidr_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.cluster_name}-lb-sg"
  }
}

# Deployment de Nginx
resource "kubernetes_deployment" "nginx" {
  metadata {
    name      = var.app_name
    namespace = var.namespace
    labels = {
      app = var.app_name
    }
  }

  spec {
    replicas = var.replicas

    selector {
      match_labels = {
        app = var.app_name
      }
    }

    template {
      metadata {
        labels = {
          app = var.app_name
        }
      }

      spec {
        container {
          name  = var.app_name
          image = "nginx:latest"

          port {
            container_port = 80
          }
        }
      }
    }
  }
}

# Service de Nginx
resource "kubernetes_service" "nginx" {
  metadata {
    name      = var.app_name
    namespace = var.namespace
    labels = {
      app = var.app_name
    }
    annotations = {
      "service.beta.kubernetes.io/aws-load-balancer-type"             = "nlb"
      "service.beta.kubernetes.io/aws-load-balancer-scheme"           = "internet-facing"
      "service.beta.kubernetes.io/aws-load-balancer-internal"         = "false"
      "service.beta.kubernetes.io/aws-load-balancer-security-groups"  = aws_security_group.lb_sg.id
    }
  }

  spec {
    selector = {
      app = var.app_name
    }

    port {
      port        = 80
      target_port = 80
      protocol    = "TCP"
    }

    type = "LoadBalancer"
  }
}
