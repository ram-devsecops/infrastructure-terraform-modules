variable "vpc_id" {
  description = "The vpc id for this environment."
}

variable "ui_app_security_group_id" {
  description = "The security group id of the ui app"
}

variable "bastion_security_group_id" {
  description = "The security group id of the bastion host"
}

variable "postgres_security_group_id" {
  description = "The security group id of postgres"
}

variable "iam_profile_name" {
  description = "IAM profile name for creating the graphql AWS Launch Configuration"
}

variable "availability_zones" {
  type = "list"
}

variable "subnets_private" {
  type = "list"
}

variable "subnets_public" {
  type = "list"
}

# Defaulted values 👇
variable "domain_cert" {
  description = "The cert domain name (in ACM)"
  default     = "*.silverbackinsights.com"
}

variable "cluster_name" {
  description = "The name to give the generated cluster"
  default     = "graphql"
}

variable "pub_key_name" {
  description = "The name of the default public key for the environment"
  default     = "sbi-bastion"
}

variable "instance_type" {
  description = "The size of the grapql instance(s)"
  default     = "t2.micro"
}

variable "min_size" {
  default = 1
}

variable "max_size" {
  default = 2
}

variable "desired_capacity" {
  default = 1
}

variable "cert_statuses" {
  description = "The list of cert statuses to search upon"
  type        = "list"
  default     = ["ISSUED"]
}
