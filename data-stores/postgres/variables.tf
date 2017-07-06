# DB variables
variable "vpc_id" {
  description = "(required) The vpc id where database should be created"
}

variable "db_password" {
  description = "(required) The master db password. Should come from an environment variable"
}

variable "subnet_ids" {
  description = "(required) List of subnet ids where auto-scaling should create instances"
  type        = "list"
}

variable "bastion_security_group_id" {
  description = "(required)  The Bastion host's security group id"
}

# Defaulted values 👇
variable "db_project_name" {
  description = "The arbitrary project name given to the db"
  default     = "SilverbackInsights"
}

variable "db_environment" {
  description = "The arbitrary environment name given to the db"
  default     = "Live"
}

variable "db_name" {
  description = "The name given to give the created database."
  default     = "silverbackinsights"
}

variable "db_username" {
  description = "(required) The master db username"
  default     = "master"
}

variable "route53_zone_name" {
  description = "Name of the hosted zone"
  default     = "internal.silverbackinsights.com."
}

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

variable "alarm_max_cpu_percentage" {
  description = "CPU alarm threshold as a percentage (default: 75)"
  default = 75
}

variable "alarm_disk_queue_threshold" {
  description = "Disk queue alarm threshold (default: 10)"
  default = 10
}

variable "alarm_free_disk_threshold_in_bytes" {
  description = "Free disk alarm threshold in bytes (default: 5000000000)"
  default = 5000000000
}

variable "alarm_free_memory_threshold_in_bytes" {
  description = "Free memory alarm threshold in bytes (default: 128000000)"
  default = 128000000
}
