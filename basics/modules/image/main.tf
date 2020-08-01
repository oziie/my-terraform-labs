# Download the Image
resource "docker_image" "image_id" {
  name = "${var.image_name}"
}