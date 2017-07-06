# The arn for the CI/CD user
variable "cicd_user_arn" {}

variable "domain" {
  default = "dev.silverbackinsights.com"
}

variable "cert_statuses" {
  type    = "list"
  default = ["ISSUED"]
}
