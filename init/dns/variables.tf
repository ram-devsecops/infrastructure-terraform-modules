variable "vpc_id" {
  description = "The vpc id for this environment."
}

variable "dns_zone_name" {
  description = "The route53 zone name"
  default = "internal.silverbackinsights.com."
}
