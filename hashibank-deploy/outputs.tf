locals {
  lb_name = split("-", split(".", kubernetes_service_v1.hashibank.status.0.load_balancer.0.ingress.0.hostname).0).0
}
