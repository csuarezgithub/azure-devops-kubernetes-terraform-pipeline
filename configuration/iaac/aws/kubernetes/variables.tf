### GENERAL ###
variable "profile" {
  type        = string
  default     = "ripley-dev"
  description = "Profile of the aws profile to use for the deployment (should correspond to the environment)"
}

variable "region" {
  type        = string
  default     = "us-east-1"
  description = "Region where the resources are going to be created"
}

variable "current_account_id" {
  type        = string
  default     = "991256897826"
  description = "Account ID of Current"
}

### BUSINESS ###
variable "owner" {
  type        = string
  default     = "GERENCIA-TRANSFORMACION-DIGITAL"
  description = "Team that this resource belongs to"
}

variable "cost_center" {
  type        = string
  default     = "CLC9925"
  description = "Business unit that this resource belongs to"
}

variable "subsidiary" {
  type        = string
  default     = "br"
  description = "Subsidiary where Project is located"
}

variable "function" {
  type        = string
  default     = "eks-cluster"
  description = "Function"
}

variable "project" {
  type        = string
  default     = "PLATAFORMA-UNICA-SD-LEJ"
  description = "Project Name"
}

variable "environment" {
  type        = string
  default     = "DEV"
  description = "Environment that is being used"
}

variable "number" {
  type        = string
  default     = "01"
  description = "Number of resource"
}

variable "responsible" {
  type        = string
  default     = "sebastian-valenzuela"
  description = "Number of resource"
}

#### NETWORKING ####
variable "cidr_block" {
  type    = list(string)
  default = ["10.0.0.0/16"]
}

variable "vpc_id" {
  type        = string
  default     = "vpc-0666ac3c409bb2aad"
  description = "VPC in which cluster will be deployed"
}

variable "public_subnets" {
  type        = list(string)
  default     = ["subnet-06fa55ed91807e332", "subnet-0ffc6ac2bce40798a", "subnet-0ac50c466eb1819c2"]
  description = "Public Subnets in which cluster will deploy workload"
}

variable "private_subnets" {
  type        = list(string)
  default     = ["subnet-05f8bc2abeb1ae4cc", "subnet-06f39cb14b7c8db65", "subnet-0928597a006ef56f6"]
  description = "Private Subnets in which cluster will deploy workload"
}

variable "hybrid_subnets" {
  type        = list(string)
  default     = ["subnet-0a9829a25915e6bb1", "subnet-0aa500ddcc7230793", "subnet-0e009e43933c74f05"]
  description = "Hybrid Subnets in which cluster will deploy workload"
}

variable "endpoint_private_access" {
  type        = bool
  default     = true
  description = "Indicates whether or not the Amazon EKS private API server endpoint is enabled. Default to AWS EKS resource and it is false"
}

variable "endpoint_public_access" {
  type        = bool
  default     = true
  description = "Indicates whether or not the Amazon EKS public API server endpoint is enabled. Default to AWS EKS resource and it is true"
}

### CONTROL PLANE ###
variable "kubernetes_version" {
  type        = string
  default     = "1.20"
  description = "Desired Kubernetes master version. If you do not specify a value, the latest available version is used"
}

variable "map_additional_iam_roles" {
  type = list(object({
    rolearn  = string
    username = string
    groups   = list(string)
  }))
  default = [{
    rolearn  = "arn:aws:iam::847309888826:role/AWSReservedSSO_BR-DEV-TESTING-PERMISSION_18238c9641ff52a0"
    username = "egarciam"
    groups   = ["system:masters"]
    }
  ]
  description = "Additional IAM roles to add to `config-map-aws-auth` ConfigMap"
}

variable "map_additional_iam_users" {
  type = list(object({
    userarn  = string
    username = string
    groups   = list(string)
  }))
  default = [{
    userarn  = "arn:aws:iam::847309888826:user/devop-user"
    username = "devops"
    groups   = ["system:masters"]
  }]
  description = "IAM Users add to config map in cluster"
}

### NODE GROUPS ###
variable "eks_instance_types" {
  type        = list(string)
  default     = ["t3a.medium"]
  description = "Set of instance types associated with the EKS Node Group. Defaults to [\"t3.medium\"]. Terraform will only perform drift detection if a configuration value is provided"
}

variable "eks_desired_size" {
  type        = number
  default     = 3
  description = "Desired number of worker nodes"
}

variable "eks_min_size" {
  type        = number
  default     = 3
  description = "The minimum size of the AutoScaling Group"
}

variable "eks_max_size" {
  type        = number
  default     = 5
  description = "The maximum size of the AutoScaling Group"
}

variable "eks_disk_size" {
  type        = number
  default     = 40
  description = "Disk size in GiB for worker nodes. Defaults to 20. Terraform will only perform drift detection if a configuration value is provided"
}

variable "ec2_ssh_key" {
  type        = string
  default     = "KEY-NG-EKS-BR-DEV-PHYGITAL-GESTION-CLUSTER-01"
  description = "Key Pair need to ssh into the node group"
}

variable "ami_image_id" {
  type        = string
  default     = "ami-04471579b4cee6af4"
  description = "AMI need to create node group"
}

### INGRESS ###
variable "apply_ingress_controller" {
  type        = bool
  default     = true
  description = "Helm chart for ALB Ingress"
}

variable "apply_kubernetes_service_account" {
  type        = bool
  default     = true
  description = "Service account created for ALB Ingress"
}

variable "apply_ingress_controller_role" {
  type        = bool
  default     = true
  description = "IAM Role for ALB Ingress Controller"
}

### APP MESH ###
variable "apply_kubernetes_appmesh_service_account" {
  type        = bool
  default     = true
  description = "Service account created for App Mesh"
}

variable "apply_app_mesh_controller_role" {
  type        = bool
  default     = true
  description = "IAM Role for App Mesh Controller"
}

variable "appmesh_policy" {
  type        = bool
  default     = true
  description = "Add App mesh Envoy Proxy authorization"
}

### CLOUDWATCH ###
variable "enabled_cluster_log_types" {
  type        = list(string)
  default     = []
  description = "Type of logs required to send to Cloudwatch"
}

variable "cloudwatch_policy" {
  type        = bool
  description = "Add CloudWatch policy"
  default     = true
}
### X-RAY ###
variable "xray_daemon" {
  type        = bool
  description = "Add X-Ray Daemon policy"
  default     = true
}