variable "vpc_id" {
  description = "(required) The vpc id where redis should be created"
}

variable "graphql_security_group_id" {
  description = "(required) The security group id of the graphql server"
}

variable "subnet_ids" {
  type = "list"
  description = "(required) Usually a list of private VPC Subnet IDs for the cache subnet group"
}

variable "dns_zone_name" {
  description = "(required) The route53 zone name to attach the redis CNAME record to"
}

# Defaults 👇
variable "parameter_group_name" {
  description = "Name of the parameter group to associate with this cache cluster"
  default     = "default.redis3.2"
}
# Defaults ☝️
