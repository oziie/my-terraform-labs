# Start the Container
resource "docker_container" "container_id" {
  name  = "${var.container_name}"
  image = "${var.image}"
  ports {
    internal = "${var.int_port}"
    external = "${var.ext_port}"
  }
}

# docker_container= resource // container_id= resource name (call the resource with this) // "name", "image", "ports"= attributes