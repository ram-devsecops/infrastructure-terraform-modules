# Create RDS pg instance
resource "aws_db_instance" "postgres" {
  storage_type            = "${var.storage_type}"
  engine                  = "${var.engine}"
  engine_version          = "${var.engine_version}"
  parameter_group_name    = "${var.parameter_group_name}"

  backup_retention_period = "${var.backup_retention_period}"
  backup_window           = "${var.backup_window}"
  maintenance_window      = "${var.maintenance_window}"

  port                    = "${var.port}"
  name                    = "${var.db_name_prefix}${count.index}"
  username                = "${var.db_username}"
  password                = "${var.db_password}"

  db_subnet_group_name    = "${var.db_subnet_group_name}"
  vpc_security_group_ids  = ["${var.security_group_ids}"]

  allocated_storage       = "${var.allocated_storage}"
  instance_class          = "${var.instance_class}"
  multi_az                = "${var.multi_az}"
  storage_encrypted       = "${var.storage_encrypted}"
  publicly_accessible     = "${var.publicly_accessible}"
  skip_final_snapshot     = "${var.skip_final_snapshot}"

  # Commented out below are prod settings
  # allocated_storage       = "100"
  # instance_class          = "db.m4.large"
  # multi_az                = true
  # storage_encrypted       = true
  # publicly_accessible     = "false"
  # skip_final_snapshot     = "false"

  tags                    = "${merge(
    var.default_tags,
    map(
      "Project",  "${var.project_name}",
      "PG",       true,
      "Postgres", true
    ),
    var.tags
  )}"
}
