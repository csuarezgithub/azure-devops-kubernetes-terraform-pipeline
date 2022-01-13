#locals {
#  subnet_ids = concat(var.public_subnets, var.hybrid_subnets)
#}

module "eks" {
  source                                   = "./modules/br-eks"
  project                                  = var.project
  owner                                    = var.owner
  cost_center                              = var.cost_center
  subsidiary                               = var.subsidiary
  function                                 = var.function
  environment                              = var.environment
  number                                   = var.number
  responsible                              = var.responsible
  vpc_id                                   = var.vpc_id
  subnet_ids                               = ["subnet-0280115d", "subnet-99c155ff", "subnet-39092d74"]
  kubernetes_version                       = var.kubernetes_version
  enabled_cluster_log_types                = var.enabled_cluster_log_types
  map_additional_iam_roles                 = var.map_additional_iam_roles
  map_additional_iam_users                 = var.map_additional_iam_users
  endpoint_private_access                  = var.endpoint_private_access
  endpoint_public_access                   = var.endpoint_public_access
  allowed_cidr_blocks                      = var.cidr_block
  apply_ingress_controller                 = var.apply_ingress_controller
  apply_kubernetes_service_account         = var.apply_kubernetes_service_account
  apply_ingress_controller_role            = var.apply_ingress_controller_role
  apply_kubernetes_appmesh_service_account = var.apply_kubernetes_appmesh_service_account
  apply_app_mesh_controller_role           = var.apply_app_mesh_controller_role
}

data "null_data_source" "wait_for_cluster_and_kubernetes_configmap" {
  inputs = {
    cluster_name             = module.eks.eks_cluster_id
    kubernetes_config_map_id = module.eks.kubernetes_config_map_id
  }
}

module "node_group" {
  source                         = "./modules/br-eks-node-group"
  project                        = var.project
  cost_center                    = var.cost_center
  subsidiary                     = var.subsidiary
  function                       = var.function
  owner                          = var.owner
  environment                    = var.environment
  number                         = var.number
  responsible                    = var.responsible
  vpc_id                         = var.vpc_id
  subnet_ids                     = var.hybrid_subnets
  cidr_block                     = var.cidr_block
  cluster_name                   = data.null_data_source.wait_for_cluster_and_kubernetes_configmap.outputs["cluster_name"]
  instance_types                 = var.eks_instance_types
  desired_size                   = var.eks_desired_size
  min_size                       = var.eks_min_size
  max_size                       = var.eks_max_size
  disk_size                      = var.eks_disk_size
  ec2_ssh_key                    = var.ec2_ssh_key
  allowed_cidr_blocks_node_group = var.cidr_block
  ami_image_id                   = var.ami_image_id
  appmesh_policy                 = var.appmesh_policy
  cloudwatch_policy              = var.cloudwatch_policy
  xray_daemon                    = var.xray_daemon
}