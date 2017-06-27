output "profile_name" {
  value = "${aws_iam_instance_profile.profile.name}"
}

output "profile_arn" {
  value = "${aws_iam_instance_profile.profile.arn}"
}

output "role_unique_id" {
  value = "${aws_iam_role.role.unique_id}"
}

output "role_name" {
  value = "${aws_iam_role.role.name}"
}

output "role_policy_name" {
  value = "${aws_iam_role_policy.policy.name}"
}

output "role_policy_arn" {
  value = "${aws_iam_role_policy.policy.arn}"
}
