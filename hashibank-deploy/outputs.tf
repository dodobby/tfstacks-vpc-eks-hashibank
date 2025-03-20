locals {
  lb_name = split("-", split(".", kubernetes_service_v1.hashibank.status.0.load_balancer.0.ingress.0.hostname).0).0
}

# Read information about the load balancer using the AWS provider.
data "aws_elb" "example" {
  name = local.lb_name
}

output "load_balancer_name" {
  value = local.lb_name
}

output "load_balancer_info" {
  value = data.aws_elb.example
}
