# VPC
module "vpc" {
  source                = "github.com/terraform-community-modules/tf_aws_vpc"

  name                  = "vpc-${var.project_name}-${var.environment}"
  cidr                  = "${var.cidr}"
  public_subnets        = "${var.public_subnets}"
  private_subnets       = "${var.private_subnets}"
  database_subnets      = "${var.database_subnets}"
  enable_nat_gateway    = "${var.enable_nat_gateway}"
  azs                   = "${var.availability_zones}"

  tags = "${merge(
    var.default_tags,
    map(
      "Environment", "${var.environment}",
      "Project",     "${var.project_name}"
    ),
    var.tags
  )}"
}
