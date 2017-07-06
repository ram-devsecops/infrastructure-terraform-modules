variable "cicd_user_arn" {
  description = "The arn for the CI/CD user"
}

variable "domain_cert" {
  description = "The cert domain name (in ACM)"
  default     = "*.silverbackinsights.com"
}

variable "domain_fqdn" {
  description = "The FQDN for the given static"
  default     = "dev.silverbackinsights.com"
}

variable "cert_statuses" {
  description = "The list of cert statuses to search upon"
  type        = "list"
  default     = ["ISSUED"]
}
