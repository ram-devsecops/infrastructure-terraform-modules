# Create IAM profile, role, and policy
module "iam" {
  source           = "../iam"
  iam_profile_name = "${var.iam_profile_name}"
}

# Create S3 bucket to be the home for our public keys
module "bucket" {
  source            = "../s3-bucket"

  bucket_name       = "silverbackinsights-bastion-keys-${var.vpc_environment}"
  acl               = "public-read"
  enable_destroying = "${var.s3_bucket_enable_destroying}"
  enable_versioning = "${var.s3_bucket_enable_versioning}"

  tags              = "${merge(
    var.default_tags,
    map(
      "Environment", "${var.vpc_environment}"
    ),
    var.tags
  )}"
}

# Get us the newest base ami to update our launch configurations
data "aws_ami" "bastion" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }

  filter {
    name   = "name"
    values = ["amzn-ami-hvm*"]
  }

  filter {
    name   = "owner-id"
    values = ["137112412989"]
  }
}

# Create bastion instance
module "bastion" {
  source                      = "github.com/terraform-community-modules/tf_aws_bastion_s3_keys"

  instance_type               = "t2.micro"
  ami_id                      = "${data.aws_ami.bastion.id}"
  iam_instance_profile        = "${module.iam.profile_name}"
  s3_bucket_name              = "${module.bucket.id}"
  vpc_id                      = "${var.vpc_id}"
  region                      = "${var.vpc_region}"
  subnet_ids                  = ["${var.subnet_ids}"]
  keys_update_frequency       = "${var.bastion_cron_update_frequency}"
  additional_user_data_script = "date"
}
