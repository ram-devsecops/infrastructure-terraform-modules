# Create elasticache subnet group
resource "aws_elasticache_subnet_group" "group" {
  name       = "redis"
  subnet_ids = ["${var.subnet_ids}"]
}

# Creeate elasticache cluster
resource "aws_elasticache_cluster" "cluster" {
  cluster_id           = "silverbackinsights"
  engine               = "redis"
  node_type            = "cache.t2.micro"
  port                 = 6379
  num_cache_nodes      = 1
  subnet_group_name    = "${aws_elasticache_subnet_group.group.name}"
  parameter_group_name = "${var.parameter_group_name}"
  security_group_ids   = ["${var.graphql_security_group_id}"]
}

# Read in dns zone
data "aws_route53_zone" "zone" {
  name    = "${var.dns_zone_name}"
  vpc_id  = "${var.vpc_id}"
}

# Add CNAME to zone
resource "aws_route53_record" "record" {
  zone_id = "${data.aws_route53_zone.zone.zone_id}"
  name    = "redis.${data.aws_route53_zone.zone.name}"
  type    = "CNAME"
  ttl     = "300"
  records = ["${aws_elasticache_cluster.cluster.cache_nodes.0.address}"]
}
