output "image_out" {
  value       = "${docker_image.image_id.latest}"
}

# docker_image= resource // image_id= resource_name(call the resource with this) // latest= attribute