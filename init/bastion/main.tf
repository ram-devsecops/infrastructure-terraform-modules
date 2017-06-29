resource "aws_key_pair" "bastion" {
  key_name   = "${var.key_name}"
  public_key = "${file(var.key_file)}"
}

# Create IAM profile, role, and policy
module "iam" {
  source           = "../iam"
  iam_profile_name = "${var.iam_profile_name}"
}

# Create S3 bucket to be the home for our public keys
module "bucket" {
  source            = "../s3-bucket"

  bucket_name       = "silverbackinsights-bastion-keys-${var.s3_bucket_name_suffix}"
  acl               = "public-read"
  enable_destroying = "${var.s3_bucket_enable_destroying}"
  enable_versioning = "${var.s3_bucket_enable_versioning}"
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

  name                        = "bastion"
  instance_type               = "t2.micro"
  ami                         = "${data.aws_ami.bastion.id}"
  iam_instance_profile        = "${module.iam.profile_name}"
  s3_bucket_name              = "${module.bucket.id}"
  vpc_id                      = "${var.vpc_id}"
  region                      = "${var.vpc_region}"
  subnet_ids                  = ["${var.subnet_ids}"]
  keys_update_frequency       = "${var.bastion_cron_update_frequency}"
  additional_user_data_script = "${var.additional_user_data_script}"
  associate_public_ip_address = "${var.enable_public_ip}"
  ssh_user                    = "ec2-user"
  key_name                    = "${var.key_name}"
}
