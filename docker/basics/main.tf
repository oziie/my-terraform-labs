# Download the latest Ghost Image
resource "docker_image" "image_id" {
  name = "${lookup(var.image_name, var.env)}"
}

# Start the Container
resource "docker_container" "container_id" {
  name  = "${lookup(var.container_name, var.env)}"
  image = "${docker_image.image_id.latest}"
  ports {
    internal = "${var.int_port}"
    external = "${lookup(var.ext_port, var.env)}"
  }
}

