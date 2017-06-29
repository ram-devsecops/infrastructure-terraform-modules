# VPC variables
variable "project_name" {
  description = "The arbitrary name you are going to give this project."
  default     = "sbi"
}

variable "region" {
  description = "The main aws region for your VPC. Defaults to us-east-1."
  default     = "us-east-1"
}

variable "availability_zones" {
  default = [
    "us-east-1a",
    "us-east-1c"
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
  default = []
}

variable "enable_nat_gateway" {
  default = true
}

variable "enable_dns_hostnames" {
  default = true
}

variable "enable_dns_support" {
  default = true
}

variable "enable_public_ip_on_launch" {
  default = true
}
