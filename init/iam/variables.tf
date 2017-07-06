variable "iam_profile_name" {
  description = "The name of IAM profile. It is used as a prefix for the role and policy as well. E.g. iam_profile_name-role, iam_profile_name-policy"
}

# Defaulted values 👇
variable "role_assume_role_policy" {
  description = "The JSON formatted policy for the iam profile's role to assume"
  default     = <<EOF
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
    }
  ]
}
EOF
}

variable "iam_role_policy" {
  description = "The policy that grants an entity permission to assume the role. https://www.terraform.io/docs/providers/aws/r/iam_role.html#assume_role_policy"
  default     = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Stmt1425916919000",
      "Effect": "Allow",
      "Action": [
        "s3:List*",
        "s3:Get*"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}
