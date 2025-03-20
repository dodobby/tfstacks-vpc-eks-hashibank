output "load_balancer_name" {
  value       = component.deploy-hashibank.load_balancer_name
}

publish_output "load_balancer_name" {
  value       = deployment.development.load_balancer_name
}
