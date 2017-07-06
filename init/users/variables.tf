# The environment that these user(s) are being created
variable "environment" {
  description = "The environment tag. Please use one of the following: dev, tst, uat, stg, or prd."
  default     = "dev"
}
