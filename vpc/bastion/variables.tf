variable "vpc_id" {
  description = "(required) The vpc id where bastion host should be created"
}

variable "vpc_region" {
  description = "(required) The default aws region for your vpc."
}

variable "vpc_environment" {
  description = "(required) The environment tag for the given vpc. Please use one of the following: d,q,s,p."
}

variable "subnet_ids" {
  description = "(required) List of subnet ids where auto-scaling should create instances"
  type        = "list"
}

variable "bastion_ami" {
  description = "The ami to base the bastion server. Defaults to ami-9be6f38c."
  default     = "ami-9be6f38c"
}

variable "bastion_cron_update_frequency" {
  description = "The cron formatted schedule for refreshing ssh keys from S3 bucket. Defaults to every 15 minutes (*/15 * * * *)"
  default     = "*/15 * * * *"
}

variable "s3_bucket_name" {
  description = "The S3 bucket name for storing keys. Defaults to sbi-infrastructure."
  default     = "sbi-infrastructure"
}

variable "s3_bucket_force_destroy" {
  description = "Whether or not to rimraf S3 bucket and contents on destroy. Defaults to false."
  default     = "false"
}

variable "iam_profile_name" {
  description = "IAM profile name for pulling public keys from S3 bucket. Defaults to s3-readonly."
  default     = "s3-readonly"
}
