# VPC outputs
output "id" {
  value = "${module.vpc.vpc_id}"
}

output "region" {
  value = "${var.region}"
}

output "default_security_group_id" {
  value = "${module.vpc.default_security_group_id}"
}

output "database_subnet_ids" {
  value = "${module.vpc.database_subnets}"
}

output "public_subnet_ids" {
  value = "${module.vpc.public_subnets}"
}

output "private_subnet_ids" {
  value = "${module.vpc.private_subnets}"
}

output "availability_zones" {
  value = ["${var.availability_zones}"]
}
