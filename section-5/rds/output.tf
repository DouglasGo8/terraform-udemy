

output "rds" {
  value = "${aws_db_instance.mariadb-inst1.endpoint}"
}
