# Create PG Alarm SNS topic
# resource "aws_sns_topic" "db_alarms" {
#   name = "db_alarms"
# }

# Create db subnet
resource "aws_db_subnet_group" "dbsg" {
  name        = "dbsg"
  description = "Default db subnet group"
  subnet_ids  = ["${var.subnet_ids}"]
  tags {
    Name = "Default DB subnet group"
  }
}

# Create RDS pg instance
module "pg" {
  source                  = "git@github.com:azavea/terraform-aws-postgresql-rds.git"

  vpc_id                  = "${var.vpc_id}"
  subnet_group            = "${aws_db_subnet_group.dbsg.id}"
  project                 = "${var.vpc_project_name}"
  engine_version          = "${var.engine_version}"
  database_identifier     = "${var.db_name}"
  database_name           = "${var.db_name}"
  database_username       = "${var.db_username}"
  database_password       = "${var.db_password}"
  multi_availability_zone = "${var.multi_az}"
  alarm_actions           = []
  # alarm_actions           = ["${aws_sns_topic.db_alarms.arn}"]
  parameter_group         = "${var.parameter_group_name}"

  allocated_storage       = "${var.allocated_storage}"
  skip_final_snapshot     = "${var.skip_final_snapshot}"
  instance_type           = "${var.instance_type}"
  storage_type            = "${var.storage_type}"
  database_port           = "${var.port}"
  backup_retention_period = "${var.backup_retention_period}"
  backup_window           = "${var.backup_window}"
  maintenance_window      = "${var.maintenance_window}"
  storage_encrypted       = "${var.storage_encrypted}"
}

resource "aws_security_group_rule" "rule" {
  type = "ingress"
  from_port = 5432
  to_port = 5432
  protocol = "tcp"
  source_security_group_id = "${var.bastion_security_group_id}"

  security_group_id = "${module.pg.database_security_group_id}"
}

# data "aws_route53_zone" "zone" {
#   name    = "${var.route53_zone_name}"
#   vpc_id  = "${var.vpc_id}"
# }
#
# resource "aws_route53_record" "pg" {
#   zone_id = "${data.aws_route53_zone.zone.zone_id}"
#   name    = "psql.${data.aws_route53_zone.zone.name}"
#   type    = "CNAME"
#   ttl     = "300"
#   records = ["${module.pg.hostname}"]
# }
