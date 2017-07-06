# Defaulted values 👇
variable "vpc_environment" {
  description = "The environment tag. Needed to determine if CI/CD user should to be created."
  default     = "dev"
}
