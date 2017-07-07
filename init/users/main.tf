# CI/CD IAM user
resource "aws_iam_user" "cicd" {
  name  = "cicd-orchestrator"
  count = "${var.vpc_environment != "prd" ? 1 : 0}"
}

resource "aws_iam_user_policy" "policy" {
  name = "AllowCloudFrontDeploys"
  user = "${aws_iam_user.cicd.name}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowCloudFrontDeploys",
      "Effect": "Allow",
      "Action": [
        "cloudfront:CreateInvalidation",
        "cloudfront:ListDistributions"
      ],
      "Resource": [
        "*"
      ]
    }
  ]
}
EOF
}
