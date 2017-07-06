output "cicd_user_name" {
  value = "${aws_iam_user.cicd.name}"
}

output "cicd_user_arn" {
  value = "${aws_iam_user.user.arn}"
}
