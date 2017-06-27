# VPC outputs
output "vpc_id" {
  value = "${module.vpc.vpc_id}"
}

output "vpc_default_security_group_id" {
  value = "${module.vpc.default_security_group_id}"
}

output "vpc_database_subnet_group" {
  value = "${module.vpc.database_subnet_group}"
}

output "vpc_database_subnets" {
  value = "${module.vpc.database_subnets}"
}

output "vpc_public_subnets" {
  value = "${module.vpc.public_subnets}"
}

output "vpc_private_subnets" {
  value = "${module.vpc.private_subnets}"
}
