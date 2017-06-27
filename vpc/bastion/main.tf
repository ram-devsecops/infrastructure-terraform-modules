# Create IAM policy
module "iam" {
  source           = "../iam"
  iam_profile_name = "${var.iam_profile_name}"
}

# Create S3 bucket to be the home for our public keys
resource "aws_s3_bucket" "ssh" {
  bucket        = "${var.s3_bucket_name}"
  acl           = "public-read"
  force_destroy = "${var.s3_bucket_force_destroy}"

  tags {
    Terraform   = true
    Name        = "${var.s3_bucket_name}"
    Environment = "${var.vpc_environment}"
    Bastion     = true
  }
}

# Create bastion instance
module "bastion" {
  source                      = "github.com/terraform-community-modules/tf_aws_bastion_s3_keys"

  instance_type               = "t2.micro"
  ami                         = "${var.bastion_ami}"
  iam_instance_profile        = "${module.iam.profile_name}"
  s3_bucket_name              = "${aws_s3_bucket.ssh.id}"
  vpc_id                      = "${var.vpc_id}"
  region                      = "${var.vpc_region}"
  subnet_ids                  = ["${var.subnet_ids}"]
  keys_update_frequency       = "${var.bastion_cron_update_frequency}"
  additional_user_data_script = "date"
}
