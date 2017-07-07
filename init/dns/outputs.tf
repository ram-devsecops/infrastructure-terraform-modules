output "id" {
  value = "${data.aws_route53_zone.zone.zone_id}"
}

output "name" {
  value = "${data.aws_route53_zone.zone.name}"
}

output "name_servers" {
  value = ["${aws_route53_zone.zone.name_servers}"]
}
