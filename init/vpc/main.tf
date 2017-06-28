# VPC
module "vpc" {
  source                  = "github.com/terraform-community-modules/tf_aws_vpc"

  name                    = "vpc"
  cidr                    = "${var.cidr}"
  public_subnets          = "${var.public_subnets}"
  private_subnets         = "${var.private_subnets}"
  database_subnets        = "${var.database_subnets}"
  enable_nat_gateway      = "${var.enable_nat_gateway}"
  enable_dns_hostnames    = "${var.enable_dns_hostnames}"
  enable_dns_support      = "${var.enable_dns_support}"
  azs                     = "${var.availability_zones}"
  map_public_ip_on_launch = "${var.enable_public_ip_on_launch}"
}
