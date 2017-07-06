# CI/CD IAM user
resource "aws_iam_user" "cicd" {
  name  = "cicd-orchestrator"
  count = "${var.environment != "prd" ? 1 : 0}"
}
