# Download the image
module "image" {
  source = "./image"
  image_name  = "${var.image_name}"
}

# Start the container
module "container" {
  source             = "./container"
  image              = "${module.image.image_out}"
  container_name     = "${var.container_name}"  # can it be like this? --> ${module.image.container_name}
  int_port           = "${var.int_port}"
  ext_port           = "${var.ext_port}"
}

# wrote "modules" according to source's variables and outputs. For example, "Container" module identified with 4 variables and "image" modules identified with 1 variables "image_name".
# outputs syntax is different than variables syntax.  for outputs: "${module.image.image_out}"  /// for variables:  "${var.container_name}"