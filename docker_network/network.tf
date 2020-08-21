resource "docker_network" "public_bridge_network" {
  name   = "public_ghost_network"
  driver = "bridge"
}

resource "docker_network" "private_bridge_network" {
  name     = "ghost_mysql_internal"
  driver   = "bridge"
  internal = true
}