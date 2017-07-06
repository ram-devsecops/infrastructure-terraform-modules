variable "vpc_id" {
  description = "The vpc id for this environment."
}

variable "kms_key_alias" {
  description = "The alias of the kms key to use for encrypting/decrypting sensitive data"
}

variable "bastion_security_group_id" {
  description = "The security group id of the bastion host"
}

variable "graphql_security_group_id" {
  description = "The security group id of the graphql server"
}

# Defaulted values 👇
variable "iam_profile_name" {
  description = "The name for the generated iam user. Defaults to ui-app."
  default = "ui-app"
}

variable "security_group_name" {
  description = "The name for the generated ALB security group. Defaults to ui-app."
  default = "ui-app"
}
