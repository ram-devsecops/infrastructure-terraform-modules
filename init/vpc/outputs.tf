# VPC outputs
output "project_name" {
  value = "${var.project_name}"
}

output "id" {
  value = "${module.vpc.vpc_id}"
}

output "environment" {
  value = "${var.environment}"
}

output "region" {
  value = "${var.region}"
}

output "default_security_group_id" {
  value = "${module.vpc.default_security_group_id}"
}

output "database_subnet_group" {
  value = "${module.vpc.database_subnet_group}"
}

output "database_subnets" {
  value = "${module.vpc.database_subnets}"
}

output "public_subnets" {
  value = "${module.vpc.public_subnets}"
}

output "private_subnets" {
  value = "${module.vpc.private_subnets}"
}
