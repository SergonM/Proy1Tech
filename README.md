
# CloudApp - Infraestructura Escalable en AWS con Terraform

## Descripción del Proyecto

Utilizando **Terraform** como herramienta de Infraestructura como Código (IaC), esta arquitectura busca garantizar alta disponibilidad, seguridad y la capacidad de manejar tráfico.

La aplicación web tiene una arquitectura de **tres capas**:
- **Frontend**: Desplegado con **Nginx** en **Amazon EKS**.
- **Lógica de negocio**: Gestionada en contenedores en **Amazon Elastic Kubernetes Service (EKS)**.
- **Base de datos**: Gestionada por **Amazon Relational Database Service (RDS)**.


## Características Principales

- Despliegue automatizado con **Terraform** para la infraestructura como código.
- **Amazon VPC** para aislar recursos con subredes públicas y privadas.
- **Amazon EKS** para la orquestación de contenedores y escalabilidad de la lógica de negocio.
- **Amazon RDS** para la gestión de base de datos MySQL con replicación entre zonas de disponibilidad.
- **CloudFront** para distribuir el contenido de manera eficiente mediante una red de distribución de contenido (CDN).

---

## Tabla de Contenidos

- [Descripción del Proyecto](#descripción-del-proyecto)
- [Características Principales](#características-principales)
- [Estructura del Proyecto](#estructura-del-proyecto)
- [Requisitos Previos](#requisitos-previos)
- [Variables de Configuración](#variables-de-configuración)
- [Despliegue de la Infraestructura](#despliegue-de-la-infraestructura)
- [Outputs](#outputs)
- [Monitoreo y Mantenimiento](#monitoreo-y-mantenimiento)

---

## Estructura del Proyecto

La infraestructura se organiza en módulos de Terraform que encapsulan distintos componentes del proyecto, lo que permite que el código sea reutilizable, modular y mantenible.

```bash
├── modules
│   ├── cloudfront
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── eks
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── nginx
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── rds
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── vpc
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
├── main.tf
├── providers.tf
├── variables.tf
├── terraform.tfvars
└── outputs.tf
```

Componentes Principales

- modules/vpc/: Define y despliega la red principal (VPC) y sus subredes públicas/privadas, gateways, tablas de rutas, y otros recursos de red.
- modules/eks/: Proporciona los recursos necesarios para desplegar el clúster de Kubernetes en EKS.
- modules/rds/: Despliega y configura una instancia de base de datos MySQL utilizando Amazon RDS.
- modules/nginx/: Despliega Nginx en contenedores dentro del clúster de Kubernetes.
- modules/cloudfront/: Configura CloudFront para distribuir el contenido con baja latencia a través de una CDN.

---

## Requisitos Previos

Antes de proceder con el despliegue, hay que de tener los siguientes componentes instalados y configurados:

- Terraform (v1.0 o superior).
- AWS CLI configurado con credenciales.
- kubectl para gestionar el clúster de Kubernetes.
- Una cuenta de AWS con los permisos necesarios para crear y gestionar recursos como VPC, EKS, RDS, y otros.

---

## Variables de Configuración

Las variables configurables están definidas en variables.tf y personalizadas en el archivo terraform.tfvars. A continuación, se presentan algunas de las variables clave que necesitarás ajustar según tu entorno:

```bash
# terraform.tfvars
aws_region       = "us-east-1"
vpc_cidr         = "10.0.0.0/16"
public_subnets   = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnets  = ["10.0.3.0/24", "10.0.4.0/24"]
azs              = ["us-east-1a", "us-east-1b"]

cluster_name     = "cloudapp-eks-cluster"

db_name          = "cloudappdb"
db_username      = "admin"
db_password      = "your-secure-password"

cloudfront_cidr_blocks = ["13.32.0.0/15", "13.35.0.0/16", "13.54.63.128/26"]
```
---

## Despliegue de la Infraestructura

Pasos para desplegar la infraestructura utilizando Terraform.

### Paso 1: Clonar el Repositorio

```bash
git clone https://github.com/SergonM/Proy1Tech.git
cd Proy1Tech
```

### Paso 2: Inicializar Terraform

Inicializa el backend de Terraform y descarga los módulos necesarios:

```bash
terraform init
```

### Paso 3: Planificar el Despliegue

Este comando genera un plan de ejecución que te permite revisar los cambios que Terraform realizará en tu infraestructura:

```bash
terraform plan
```

### Paso 4: Aplicar el Despliegue

Aplica los cambios para desplegar la infraestructura en tu cuenta de AWS:

```bash
terraform apply
```

Una vez confirmado, Terraform comenzará a crear todos los recursos, como la VPC, el clúster EKS, las subredes, la base de datos RDS, etc.

### Paso 5: Configurar kubectl

Después de que el clúster EKS haya sido creado, configura kubectl para gestionar el clúster de Kubernetes:

```bash
aws eks --region us-east-1 update-kubeconfig --name cloudapp-eks-cluster
```

---

## Outputs

El archivo outputs.tf expone información importante sobre los recursos creados. Algunos de los outputs relevantes incluyen:

- `vpc_id`: ID de la VPC creada.
- `eks_cluster_name`: Nombre del clúster de Kubernetes.
- `rds_endpoint`: Endpoint para conectarse a la base de datos RDS.
- `cloudfront_domain_name`: Dominio asignado por CloudFront.

Ejemplo de salida después de aplicar Terraform:

```bash
Outputs:

vpc_id = "vpc-0a1234b56789cde01"
eks_cluster_name = "cloudapp-eks-cluster"
rds_endpoint = "cloudappdb.c1234567890.us-east-1.rds.amazonaws.com"
cloudfront_domain_name = "d123456789abcdef.cloudfront.net"
```

---

## Monitoreo y Mantenimiento

### Monitoreo con AWS CloudWatch

Se recomienda configurar Amazon CloudWatch para monitorear los siguientes recursos:

- Uso de CPU y memoria en los nodos de EKS.
- Latencia y rendimiento de la base de datos RDS.
- Estado del balanceador de carga y el tráfico en CloudFront.

Puedes configurar alarmas en CloudWatch para recibir notificaciones en caso de problemas críticos, como un aumento inusual en la latencia o la indisponibilidad de un servicio.

### Escalado Automático

Para asegurar que la infraestructura se mantenga escalable, es recomendable configurar los siguientes mecanismos:

- Auto Scaling Groups para los nodos de EKS.
- Horizontal Pod Autoscaler (HPA) para los contenedores en Kubernetes.

Esto garantizará que la infraestructura pueda ajustarse automáticamente en función de la demanda del tráfico.


