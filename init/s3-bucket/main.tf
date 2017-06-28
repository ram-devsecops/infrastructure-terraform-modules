# Create an S3 bucket
resource "aws_s3_bucket" "bucket" {
  bucket        = "${var.bucket_name}"
  acl           = "${var.acl}"
  force_destroy = "${var.enable_destroying}"

  versioning {
    enabled = "${var.enable_versioning}"
  }
}
