resource "docker_secret" "mysql_root_password" {
  name = "root_password"
  data = "${var.mysql_root_pw}"
}

resource "docker_secret" "mysql_db_password" {
  name = "db_password"
  data = "${var.mysql_db_pw}"
}