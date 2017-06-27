# VPC variables
variable "project_name" {
  description = "The arbitrary name you are going to give this project."
  default     = "sbi"
}

variable "environment" {
  description = "The environment tag. Please use one of the following: d,q,s,p. Defaults to d (dev)."
}

variable "region" {
  description = "The main aws region for your VPC. Defaults to us-east-2."
  default     = "us-east-2"
}

variable "availability_zones" {
  default = [
    "us-east-2a",
    "us-east-2c"
  ]
}

variable "cidr" {
  default = "10.0.0.0/16"
}


variable "private_subnets" {
  type = "list"
  default = [
    "10.0.1.0/24",
    "10.0.2.0/24"
  ]
}

variable "public_subnets" {
  type = "list"
  default = [
    "10.0.101.0/24",
    "10.0.102.0/24"
  ]
}

variable "database_subnets" {
  type = "list"
  default = [
    "10.0.201.0/24",
    "10.0.202.0/24"
  ]
}

variable "enable_nat_gateway" {
  default = true
}

variable "default_tags" {
  default = {
    Terraform = true
  }
}

variable "tags" {
  default = {}
}
