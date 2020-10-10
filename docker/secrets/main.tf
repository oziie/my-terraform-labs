resource "docker_service" "mysql-service" {
  name = "mysql_db"

  task_spec {
    container_spec {
      image = "${docker_image.mysql_image.name}"

      secrets = [
        {
          secret_id   = "${docker_secret.mysql_root_password.id}"
          secret_name = "${docker_secret.mysql_root_password.name}"
          file_name   = "/run/secrets/${docker_secret.mysql_root_password.name}"
        },
        {
          secret_id   = "${docker_secret.mysql_db_password.id}"
          secret_name = "${docker_secret.mysql_db_password.name}"
          file_name   = "/run/secrets/${docker_secret.mysql_db_password.name}"
        }
      ]

      env {
        MYSQL_ROOT_PASSWORD_FILE = "/run/secrets/${docker_secret.mysql_root_password.name}"
        MYSQL_DATABASE           = "mydb"
        MYSQL_PASSWORD_FILE      = "/run/secrets/${docker_secret.mysql_db_password.name}"
      }

      mounts = [
        {
          target = "/var/lib/mysql"
          source = "${docker_volume.mysql_data_volume.name}"
          type   = "volume"
        }
      ]
    }
    networks = [
      "${docker_network.private_overlay_network.name}"
    ]
  }
}