# VPC
module "vpc" {
  source                = "github.com/terraform-community-modules/tf_aws_vpc"

  name                  = "vpc-${var.vpc_project_name}-${var.vpc_environment}"
  cidr                  = "${var.vpc_cidr}"
  public_subnets        = "${var.vpc_public_subnets}"
  private_subnets       = "${var.vpc_private_subnets}"
  database_subnets      = "${var.vpc_database_subnets}"
  enable_nat_gateway    = "${var.vpc_enabled_nat_gateway}"
  azs                   = "${var.vpc_availability_zones}"

  tags {
    Terraform   = true
    Environment = "${var.vpc_environment}"
    Project     = "${var.vpc_project_name}"
  }
}
