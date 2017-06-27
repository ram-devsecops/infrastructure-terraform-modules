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
  default     = "silverbackinsights-bastion-keys"
}

variable "s3_bucket_enable_destroying" {
  description = "Whether or not to allow rimraf S3 bucket and contents. Defaults to false."
  default     = "false"
}

variable "iam_profile_name" {
  description = "IAM profile name for pulling public keys from S3 bucket. Defaults to s3-readonly."
  default     = "s3-readonly"
}

variable "default_tags" {
  default = {
    Terraform = true
    Bastion   = true
  }
}

variable "tags" {
  default = {}
}
