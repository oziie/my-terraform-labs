#Output the IP Address of the Container
output "ip" {
  value = "${module.container.ip}"
}

output "container_name" {
  value = "${module.container.container_name}"
}