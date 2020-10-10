resource "docker_container" "mysql_container" {
  name  = "ghost_database"
  image = "${docker_image.mysql_image.name}"
  env   = [
    "MYSQL_ROOT_PASSWORD=${var.mysql_root_password}"
  ]
  networks_advanced {
    name    = "${docker_network.private_bridge_network.name}"
    aliases = ["${var.mysql_network_alias}"]
  }
}

resource "null_resource" "sleep" {
  depends_on = ["docker_container.mysql_container"]
  provisioner "local-exec" {
    command = "sleep 15s"
  }
}

resource "docker_container" "blog_container" {
  name  = "ghost_blog"
  image = "${docker_image.ghost_image.name}"
  depends_on = ["null_resource.sleep", "docker_container.mysql_container"]
  env   = [
    "database__client=mysql",
    "database__connection__host=${var.mysql_network_alias}",
    "database__connection__user=${var.ghost_db_username}",
    "database__connection__password=${var.mysql_root_password}",
    "database__connection__database=${var.ghost_db_name}"
  ]
  ports {
    internal = "2368"
    external = "${var.ext_port}"
  }
  networks_advanced {
    name    = "${docker_network.public_bridge_network.name}"
    aliases = ["${var.ghost_network_alias}"]
  }
  networks_advanced {
    name    = "${docker_network.private_bridge_network.name}"
    aliases = ["${var.ghost_network_alias}"]
  }
}