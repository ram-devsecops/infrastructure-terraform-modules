output "dns_cname_record_name" {
  value = "redis.${data.aws_route53_zone.zone.name}"
}
