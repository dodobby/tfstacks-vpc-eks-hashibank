locals {
  lb_name = kubernetes_ingress_v1.hashibank.status[0].load_balancer[0].ingress[0].hostname
}

output "load_balancer_name" {
  value = local.lb_name
}
