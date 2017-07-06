# Create ECS user role
resource "aws_iam_role" "ecs" {
  name               = "${var.iam_profile_name}-role"
  path               = "/"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
      "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    },
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
      "Service": "ecs.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

# Create ECS user profile
resource "aws_iam_instance_profile" "profile" {
  name = "${var.iam_profile_name}"
  role = "${aws_iam_role.ecs.name}"
}

# Attach default ECS role policy
resource "aws_iam_role_policy_attachment" "ecs_default" {
  role       = "${aws_iam_role.ecs.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceRole"
}

# Attach ECS for EC2 role policy
resource "aws_iam_role_policy_attachment" "ecs_for_ec2" {
  role       = "${aws_iam_role.ecs.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

# Create Cloudwatch Logs policy
resource "aws_iam_policy" "ecs_cloudwatch_logs" {
  name        = "ecs-cloudwatch-logs-policy"
  path        = "/"
  description = "ECS task CloudWatch Logs"
  policy      = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "logs:DescribeLogStreams"
      ],
      "Resource": [
        "arn:aws:logs:*:*:*"
      ]
    }
  ]
}
EOF
}

# Attach CloudWatch logs policy to ECS role
resource "aws_iam_role_policy_attachment" "ecs_cloudwatch_logs" {
  role       = "${aws_iam_role.ecs.name}"
  policy_arn = "${aws_iam_policy.ecs_cloudwatch_logs.arn}"
}

# Create CI/CD ECS policy to manage Load Balancers
resource "aws_iam_policy" "ecs_cicd" {
  name        = "ecs-cicd-policy"
  path        = "/"
  description = "ECS CI/CD Load Balancer Management"
  policy      = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "elasticloadbalancing:Describe*",
        "elasticloadbalancing:DeregisterInstancesFromLoadBalancer",
        "elasticloadbalancing:RegisterInstancesWithLoadBalancer",
        "ec2:Describe*",
        "ec2:AuthorizeSecurityGroupIngress"
      ],
      "Resource": [
        "*"
      ]
    }
  ]
}
EOF
}

# Associate the CI/CD load balancer management policy to ECS CI/CD role
resource "aws_iam_role_policy_attachment" "ecs_cicd_alb" {
  role       = "${aws_iam_role.ecs.name}"
  policy_arn = "${aws_iam_policy.ecs_cicd.arn}"
}

resource "aws_iam_role_policy_attachment" "ecs_efs_full" {
  role       = "${aws_iam_role.ecs.name}"
  policy_arn = "arn:aws:iam::aws:policy/AmazonElasticFileSystemFullAccess"
}

resource "aws_iam_role_policy_attachment" "ecs_s3_full" {
  role       = "${aws_iam_role.ecs.name}"
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

data "aws_kms_alias" "sensitive" {
  name = "alias/${var.kms_key_alias}"
}

resource "aws_iam_role_policy" "ecs_kms" {
  name   = "kms-usage"
  role   = "${aws_iam_role.ecs.id}"
  policy = <<EOF
{
  "Id": "key-consolepolicy-1",
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowUseOfTheKey",
      "Effect": "Allow",
      "Action": [
        "kms:Encrypt",
        "kms:Decrypt",
        "kms:ReEncrypt*",
        "kms:GenerateDataKey*",
        "kms:DescribeKey"
      ],
      "Resource": [
        "${data.aws_kms_alias.sensitive.arn}"
      ]
    },
    {
      "Sid": "AllowAttachmentOfPersistentResources",
      "Effect": "Allow",
      "Action": [
        "kms:CreateGrant",
        "kms:ListGrants",
        "kms:RevokeGrant"
      ],
      "Resource": [
        "${data.aws_kms_alias.sensitive.arn}"
      ],
      "Condition": {
        "Bool": {
          "kms:GrantIsForAWSResource": true
        }
      }
    }
  ]
}
EOF
}

# Create CloudWatch log group
resource "aws_cloudwatch_log_group" "logs" {
  name = "logs"
}

# UI App Security Group
resource "aws_security_group" "app" {
  vpc_id      = "${var.vpc_id}"
  name        = "${var.security_group_name}"
  description = "Security group for the bare essentials for the ELB & ECS"

  tags {
    Name = "${var.security_group_name}"
  }
}

# Allow SSH from the bastion host
resource "aws_security_group_rule" "ssh_in" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
	source_security_group_id = "${var.bastion_security_group_id}"

  security_group_id        = "${aws_security_group.app.id}"
}

# Allow https
resource "aws_security_group_rule" "https_in" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
	cidr_blocks			  = ["0.0.0.0/0"]

  security_group_id = "${aws_security_group.app.id}"
}

# Allow outbound from ECS to graphql ECS
resource "aws_security_group_rule" "api_out" {
  type                     = "egress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = "${var.graphql_security_group_id}"

  security_group_id        = "${aws_security_group.app.id}"
}

# Allow outbound from ECS to graphql ECS over websockets
resource "aws_security_group_rule" "web_ui-api-ws-out" {
  type                     = "egress"
  from_port                = 8091
  to_port                  = 8091
  protocol                 = "tcp"
  source_security_group_id = "${var.graphql_security_group_id}"

  security_group_id        = "${aws_security_group.app.id}"
}
