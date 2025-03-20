variable "AWS_ACCESS_KEY_ID" {
  type = string
  default = ""
}

variable "AWS_SECRET_ACCESS_KEY" {
  type = string
  default = ""
}

variable "regions" {
  type = set(string)
}

variable "aws_identity_token" {
  type = string
  ephemeral = true
  sensitive = true
  default = ""
}

variable "k8s_identity_token" {
  type = string
  ephemeral = true
  sensitive = true
}

variable "workload_idp_name" {
  type = string
  default = "tfstacks-workload-identity-provider"
}

variable "aws_auth_roles" {
  type = list(object({
    rolearn  = string
    username = string
    groups   = list(string)
  }))
  default = []
}

variable "role_arn" {
  type = string
  default = ""
}

variable "vpc_name" {
  type = string 
}

variable "vpc_cidr" {
  type = string
}

variable "kubernetes_version" {
  type = string
  default = "1.29"
}

variable "cluster_name" {
  type = string
  default = "eks-cluster"
}

variable "namespace" {
  type = string
  default = "hashibank"
}

variable "tfc_hostname" {
  type = string
}

variable "tfc_organization_name" {
  type = string
}

variable "tfc_kubernetes_audience" {
  type = string
}
variable "eks_clusteradmin_arn" {
  type = string
}

variable "eks_clusteradmin_username" {
  type = string
}

