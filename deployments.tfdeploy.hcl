identity_token "aws" {
  audience = ["aws.workload.identity"]
}



identity_token "k8s" {
  audience = ["k8s.workload.identity"]
}


deployment "development" {
  inputs = {
    aws_identity_token = identity_token.aws.jwt
    role_arn            = "arn:aws:iam::552166050235:role/stacks-rum-org-korean-air-hjdo-eks" #mod
    regions             = ["ca-central-1"] #mod
    vpc_name = "vpc-dev2"
    vpc_cidr = "10.0.0.0/16"

    #EKS Cluster
    kubernetes_version = "1.30"
    cluster_name = "eksdev02"
    
    #EKS OIDC
    tfc_kubernetes_audience = "k8s.workload.identity"
    tfc_hostname = "https://app.terraform.io"
    tfc_organization_name = "rum-org-korean-air" #mod
    eks_clusteradmin_arn = "arn:aws:iam::552166050235:role/hjdo-eks-cluster-role-for-stacks" #mod
    eks_clusteradmin_username = "hjdo-developer" #mod

    #K8S
    k8s_identity_token = identity_token.k8s.jwt
    namespace = "hashibank"

  }
}

deployment "prod" {
  inputs = {
    aws_identity_token = identity_token.aws.jwt
    role_arn            = "arn:aws:iam::552166050235:role/stacks-rum-org-korean-air-hjdo-eks" #mod
    regions             = ["ca-central-1"] #mod
    vpc_name = "vpc-prod2"
    vpc_cidr = "10.20.0.0/16"

    #EKS Cluster
    kubernetes_version = "1.30"
    cluster_name = "eksprod02"
    
    #EKS OIDC
    tfc_kubernetes_audience = "k8s.workload.identity"
    tfc_hostname = "https://app.terraform.io"
    tfc_organization_name = "rum-org-korean-air" #mod
    eks_clusteradmin_arn = "arn:aws:iam::552166050235:role/hjdo-eks-cluster-role-for-stacks" #mod
    eks_clusteradmin_username = "hjdo-producer" #mod

    #K8S
    k8s_identity_token = identity_token.k8s.jwt
    namespace = "hashibank"

  }
}

orchestrate "auto_approve" "safe_plans_dev" {
  check {
      # Only auto-approve in the development environment if no resources are being removed
      condition = context.plan.changes.remove == 0 && context.plan.deployment == deployment.development
      reason = "Plan has ${context.plan.changes.remove} resources to be removed."
  }
}
