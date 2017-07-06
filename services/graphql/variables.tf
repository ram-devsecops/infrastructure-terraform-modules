variable "vpc_id" {}
variable "vpc_environment" {}
variable "ui_app_security_group_id" {}
variable "bastion_security_group_id" {}
variable "postgres_security_group_id" {}
variable "ecs_instance_role_name" {}

variable "availability_zones" {
  type = "list"
}

variable "subnets" {
  type = "list"
}

variable "subnets_private" {
  type = "list"
}

variable "subnets_public" {
  type = "list"
}

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

variable "ecs_instance_type" {
  description = "The size of the grapql instance(s)"
  default     = "t2.small"
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
