# “Services”(docker-service) describes the desired state. “Tasks” for doing all the work.

resource "docker_service" "ghost-service" {
  name = "ghost"

### “container_spec” describes how to container looks like.
  task_spec {
    container_spec {
      image = "${docker_image.ghost_image.name}"

      env {
         database__client               = "mysql"
         database__connection__host     = "${var.mysql_network_alias}"
         database__connection__user     = "${var.ghost_db_username}"
         database__connection__password = "${var.mysql_root_password}"
         database__connection__database = "${var.ghost_db_name}"
      }
    }
    networks = [
      "${docker_network.public_bridge_network.name}",
      "${docker_network.private_bridge_network.name}"
    ]
  }

### “endpoint_spec” is for define load balancing endpoints:
###         -“target_port” is for Ghost blog.
###         - “published_port” is to access service.

  endpoint_spec {
    ports {
      target_port    = "2368"
      published_port = "${var.ext_port}"
    }
  }
}

resource "docker_service" "mysql-service" {
  name = "${var.mysql_network_alias}"

  task_spec {
    container_spec {
      image = "${docker_image.mysql_image.name}"

      env {
        MYSQL_ROOT_PASSWORD = "${var.mysql_root_password}"
      }

### We need to use “mounts” rather than “volumes” when use Docker Swarm services.
### In the “mounts” --> “type”, we have 3 option to use: bind, volume, tmpfs
      mounts = [
        {
          target = "/var/lib/mysql"
          source = "${docker_volume.mysql_data_volume.name}"
          type   = "volume"
        }
      ]
    }
    networks = ["${docker_network.private_bridge_network.name}"]
  }
}