# DB variables
variable "project_name" {
  description = "(required) The arbitrary name you are going to give this project."
}

variable "vpc_environment" {
  description = "(required) The environment tag. Please use one of the following: d,q,s,p."
}

variable "db_name_prefix" {
  description = "(required) The prefix to give the created database. Always appended with the index of the database. E.g., mydatabase0, mydatabse1, etc."
}

variable "db_username" {
  description = "(required) The master db username"
}

variable "db_password" {
  description = "(required) The master db password. Should come from an environment variable"
}

variable "db_subnet_group_name" {
  description = "(required) Your database subnet group name"
}

variable "security_group_ids" {
  description = "List of VPC security groups to associate."
  type        = "list"
  default     = []
}

# Self-explanatory custom defaults
variable "allocated_storage" {
  default = 5
}
variable "storage_type" {
  default = "gp2"
}
variable "engine" {
  default = "postgres"
}
variable "engine_version" {
  default = "9.6.2"
}
variable "instance_class" {
  default = "db.t2.micro"
}
variable "parameter_group_name" {
  default = "default.postgres9.6"
}

variable "backup_retention_period" {
  default = "30"
}
variable "backup_window" {
  default = "04:00-04:30"
}
variable "maintenance_window" {
  default = "sun:04:30-sun:05:30"
}

variable "port" {
  default = 5432
}

variable "multi_az" {
  default = false
}
variable "storage_encrypted" {
  default = false
}
variable "publicly_accessible" {
  default = false
}
variable "skip_final_snapshot" {
  default = true
}
