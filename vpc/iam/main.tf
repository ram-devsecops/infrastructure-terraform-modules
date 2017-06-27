# Definition of IAM instance profile which is allowed to read-only from S3.
resource "aws_iam_role" "role" {
  name = "${var.iam_profile_name}-role"
  path = "/"

  assume_role_policy = "${var.iam_role_role_policy}"
}

resource "aws_iam_role_policy" "policy" {
  name = "${var.iam_profile_name}-policy"
  role = "${aws_iam_role.role.id}"

  policy = "${var.iam_role_policy}"
}

resource "aws_iam_instance_profile" "profile" {
  name = "${var.iam_profile_name}"
  role = "${aws_iam_role.role.name}"
}
