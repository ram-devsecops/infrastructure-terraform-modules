# Create internal zone
resource "aws_route53_zone" "zone" {
  name   = "${var.dns_zone_name}"
  vpc_id = "${var.vpc_id}"
}

# Pull the newly created zone info
data "aws_route53_zone" "zone" {
  name    = "${var.dns_zone_name}"
  vpc_id  = "${var.vpc_id}"
}
