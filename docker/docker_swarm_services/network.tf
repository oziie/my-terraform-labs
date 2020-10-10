resource "docker_network" "public_bridge_network" {
  name   = "public_ghost_network"
  driver = "ovarlay"
}

resource "docker_network" "private_bridge_network" {
  name     = "ghost_mysql_internal"
  driver   = "overlay"
  internal = true
}

### Docker “bridge” network adaptor is only works for individual Docker hosts. 
### We need to set network adaptor for both public and private network as “overlay”. 
### Because we are working on Docker swarm which means multiple host. “overlay” can work with multiple docker hosts.
