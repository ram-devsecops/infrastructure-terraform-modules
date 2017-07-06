resource "aws_kms_key" "key" {
  description = "${var.description}"
}

resource "aws_kms_alias" "alias" {
  name          = "alias/${var.alias}"
  target_key_id = "${aws_kms_key.key.key_id}"
}
