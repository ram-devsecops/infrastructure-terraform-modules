output "s3_bucket_name" {
  value = "${module.bucket.id}"
}

output "security_group_id" {
  value = "${module.bastion.security_group_id}"
}

output "ssh_user" {
  value = "${module.bastion.ssh_user}"
}
