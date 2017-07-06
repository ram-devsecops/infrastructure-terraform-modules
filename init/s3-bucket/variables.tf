variable "bucket_name" {
  description = "(required) The S3 bucket name."
}

# Defaulted values 👇
variable "acl" {
  description = "The acl for the bucket. Defaults to private. More details can be found here: https://docs.aws.amazon.com/AmazonS3/latest/dev/acl-overview.html#canned-acl"
  default = "private"
}

variable "enable_destroying" {
  description = "Whether or not to allow rimraf of S3 bucket. Defaults to true."
  default = true
}

variable "enable_versioning" {
  description = "Whether or not to enable object versioning. Defaults to false."
  default = false
}
