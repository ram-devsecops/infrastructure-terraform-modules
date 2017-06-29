# DB variables
variable "vpc_id" {
  description = "(required) The vpc id where database should be created"
}

variable "db_password" {
  description = "(required) The master db password. Should come from an environment variable"
}

variable "security_group_ids" {
  description = "(required) List of VPC security groups to associate."
  type        = "list"
}

variable "subnet_ids" {
  description = "(required) List of subnet ids where auto-scaling should create instances"
  type        = "list"
}

variable "vpc_project_name" {
  description = "The arbitrary project name given to the vpc"
  default     = "SilverbackInsights"
}

variable "db_name" {
  description = "The name given to give the created database."
  default     = "silverbackinsights"
}

variable "db_username" {
  description = "(required) The master db username"
  default     = "master"
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

variable "instance_type" {
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
