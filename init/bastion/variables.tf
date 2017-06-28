variable "vpc_id" {
  description = "(required) The vpc id where bastion host should be created"
}

variable "vpc_region" {
  description = "(required) The default aws region for your vpc."
}

variable "subnet_ids" {
  description = "(required) List of subnet ids where auto-scaling should create instances"
  type        = "list"
}

variable "key_name" {
  description = "(required) Launch configuration key name to be applied to created instance(s)"
}

variable "key_file" {
  description = "(required) The relative path to the public key file"
}

variable "enable_public_ip" {
  default = true
}

variable "bastion_cron_update_frequency" {
  description = "The cron formatted schedule for refreshing ssh keys from S3 bucket. Defaults to every 15 minutes (*/15 * * * *)"
  default     = "*/15 * * * *"
}

variable "s3_bucket_enable_destroying" {
  description = "Whether or not to allow rimraf S3 bucket and contents. Defaults to false."
  default     = false
}

variable "s3_bucket_enable_versioning" {
  description = "Whether or not to allow versioning of S3 bucket contents. Defaults to true."
  default     = true
}

variable "additional_user_data_script" {
  description = "The body of any custom script that should be run after instance is up"
  default     = "date"
}

variable "iam_profile_name" {
  description = "IAM profile name for pulling public keys from S3 bucket. Defaults to s3-readonly."
  default     = "s3-readonly"
}
