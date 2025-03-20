locals {
  lb_name = kubernetes_ingress_v1.hashibank.status[0].load_balancer[0].ingress[0].hostname
}

data "aws_elb" "example" {
  name = local.lb_name
}

output "load_balancer_name" {
  value = local.lb_name
}

output "load_balancer_info" {
  value = data.aws_elb.hashibank
}
