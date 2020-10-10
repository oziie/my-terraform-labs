#Define variables
variable "env" {
   description = "env: dev or prod"
}

variable "image_name" {
  type	      = "map"
  description = "Image for container."
    default     = {
    dev  = "ghost:latest"
    prod = "ghost:alpine"
  }
}

variable "container_name" {
  type	      = "map"
  description = "Name of the container."
    default     = {
    dev  = "blog_dev"
    prod = "blog_prod"
  }
}

variable "int_port" {
  description = "Internal port for container."
  default     = "2368"
}

variable "ext_port" {
  description = "External port for container."
    default     = {
    dev  = "8081"
    prod = "80"
  }
}
