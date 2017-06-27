output "s3_bucket_name" {
  value = "${module.bucket.id}"
}

output "bastion_security_group_id" {
  value = "${module.bastion.security_group_id}"
}

output "bastion_ssh_user" {
  value = "${module.bastion.ssh_user}"
}
