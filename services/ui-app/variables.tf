variable "vpc_id" {
  description = "The vpc id for this environment."
}

variable "vpc_environment" {
  description = "The environment tag. Please use one of the following: dev, tst, uat, stg, or prd."
}

variable "kms_key_alias" {
  description = "The alias of the kms key to use for encrypting/decrypting sensitive data"
}

variable "bastion_security_group_id" {}
variable "graphql_security_group_id" {}

variable "iam_profile_name" {
  description = "The name for the generated iam user. Defaults to ui-app."
  default = "ui-app"
}

variable "security_group_name" {
  description = "The name for the generated ALB security group. Defaults to ui-app."
  default = "ui-app"
}
