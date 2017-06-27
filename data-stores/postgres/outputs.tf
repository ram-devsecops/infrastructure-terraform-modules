output "db_name" {
  value = "${aws_db_instance.postgres.name}"
}

output "db_arn" {
  value = "${aws_db_instance.postgres.arn}"
}
