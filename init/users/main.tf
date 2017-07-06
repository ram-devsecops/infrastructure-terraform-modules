# CI/CD IAM user
resource "aws_iam_user" "cicd" {
  name  = "cicd-orchestrator"
  count = "${var.vpc_environment != "prd"}"
}
