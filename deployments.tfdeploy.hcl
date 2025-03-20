identity_token "aws" {
  audience = ["aws.workload.identity"]
}

identity_token "k8s" {
  audience = ["k8s.workload.identity"]
}

store "varset" "static_credentials" {
  id       = "varset-mTNaB3YGsQTb2e1p"
  category = "env"
}



deployment "development" {
  inputs = {
    AWS_ACCESS_KEY_ID     = store.varset.static_credentials.AWS_ACCESS_KEY_ID
    AWS_SECRET_ACCESS_KEY = store.varset.static_credentials.AWS_SECRET_ACCESS_KEY
    role_arn            = "arn:aws:iam::552166050235:role/stacks-rum-org-korean-air-hjdo-eks"
    regions             = ["ca-central-1"]
    vpc_name = "vpc-dev2"
    vpc_cidr = "10.0.0.0/16"

    #EKS Cluster
    kubernetes_version = "1.30"
    cluster_name = "eks-dev"
    
    #EKS OIDC
    tfc_kubernetes_audience = "k8s.workload.identity"
    tfc_hostname = "https://app.terraform.io"
    tfc_organization_name = "rum-org-korean-air"
    eks_clusteradmin_arn = "arn:aws:iam::552166050235:role/hjdo-eks-cluster-role-for-stacks"
    eks_clusteradmin_username = "hjdo-developer"

    #K8S
    k8s_identity_token = identity_token.k8s.jwt
    namespace = "hashibank"

  }
}

deployment "prod" {
  inputs = {
    aws_identity_token = identity_token.aws.jwt
    role_arn            = "arn:aws:iam::552166050235:role/stacks-rum-org-korean-air-hjdo-eks"
    regions             = ["ca-central-1"]
    vpc_name = "vpc-prod2"
    vpc_cidr = "10.20.0.0/16"

    #EKS Cluster
    kubernetes_version = "1.30"
    cluster_name = "eks-prod"
    
    #EKS OIDC
    tfc_kubernetes_audience = "k8s.workload.identity"
    tfc_hostname = "https://app.terraform.io"
    tfc_organization_name = "rum-org-korean-air"
    eks_clusteradmin_arn = "arn:aws:iam::552166050235:role/hjdo-eks-cluster-role-for-stacks"
    eks_clusteradmin_username = "hjdo-producer"

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
