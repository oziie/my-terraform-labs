resource "docker_network" "private_overlay_network" {
  name     = "mysql_internal"
  driver   = "overlay"
  internal = true
}