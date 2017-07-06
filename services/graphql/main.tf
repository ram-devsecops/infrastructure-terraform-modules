# Create security group to allow incoming connections
resource "aws_security_group" "graphql" {
  name        = "${var.cluster_name}"
  description = "Allow incoming api connections."
  vpc_id = "${var.vpc_id}"

  tags {
    Name = "${var.cluster_name}"
  }
}

# Allow Graphiql in
resource "aws_security_group_rule" "graphiql-in" {
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = "${var.ui_app_security_group_id}"

  security_group_id        = "${aws_security_group.graphql.id}"
}

# Allow Graphiql websockets in
resource "aws_security_group_rule" "websockets-in" {
  type                     = "ingress"
  from_port                = 8091
  to_port                  = 8091
  protocol                 = "tcp"
  source_security_group_id = "${var.ui_app_security_group_id}"

  security_group_id        = "${aws_security_group.graphql.id}"
}


# Allow SSH from the bastion host
resource "aws_security_group_rule" "ssh-in" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
	source_security_group_id = "${var.bastion_security_group_id}"

  security_group_id        = "${aws_security_group.graphql.id}"
}

# Allow PG in
resource "aws_security_group_rule" "pg-in" {
  type                     = "ingress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
	source_security_group_id = "${var.postgres_security_group_id}"

  security_group_id        = "${aws_security_group.graphql.id}"
}

# Allow http in
resource "aws_security_group_rule" "http-in" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]

  security_group_id = "${aws_security_group.graphql.id}"
}

# Allow https in
resource "aws_security_group_rule" "https-in" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]

  security_group_id = "${aws_security_group.graphql.id}"
}

# Allow https out
resource "aws_security_group_rule" "https-out" {
  type              = "egress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]

  security_group_id = "${aws_security_group.graphql.id}"
}

# Allow NFS in
resource "aws_security_group_rule" "nfs-in" {
  type              = "ingress"
  from_port         = 2049
  to_port           = 2049
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]

  security_group_id = "${aws_security_group.graphql.id}"
}

# Allow NFS out
resource "aws_security_group_rule" "nfs-out" {
  type              = "egress"
  from_port         = 2049
  to_port           = 2049
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]

  security_group_id = "${aws_security_group.graphql.id}"
}

# Allow Redis in
resource "aws_security_group_rule" "graphql-redis-in" {
  type            = "ingress"
  from_port       = 6379
  to_port         = 6379
  protocol        = "tcp"
  source_security_group_id = "${aws_security_group.graphql.id}"

  security_group_id = "${aws_security_group.graphql.id}"
}

# Allow Redis out
resource "aws_security_group_rule" "graphql-redis-out" {
  type            = "egress"
  from_port       = 6379
  to_port         = 6379
  protocol        = "tcp"
  cidr_blocks     = ["0.0.0.0/0"]

  security_group_id = "${aws_security_group.graphql.id}"
}

# Create ecs service cluster
resource "aws_ecs_cluster" "ecs_cluster" {
  name = "${var.cluster_name}"
}

# Find the freshest Amazon Linux AMI
data "aws_ami" "ami" {
  most_recent = true

  owners = ["137112412989"]

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "name"
    values = ["amzn-ami-hvm-*"]
  }
}

resource "aws_launch_configuration" "ecs_launch_config" {
  name_prefix                 = "${var.cluster_name}-"
  image_id                    = "${data.aws_ami.ami.id}"
  instance_type               = "${var.instance_type}"
  key_name                    = "${var.pub_key_name}"
  security_groups             = ["${aws_security_group.graphql.id}"]
  iam_instance_profile        = "${var.iam_profile_name}"
  associate_public_ip_address = false
  user_data                   = "#!/bin/bash\necho ECS_CLUSTER=\"${aws_ecs_cluster.ecs_cluster.name}\" >> /etc/ecs/ecs.config"

  lifecycle {
    create_before_destroy = true
  }

  ebs_block_device {
    device_name = "/dev/xvdcz"
    volume_size = "22"
    volume_type = "gp2"
  }
}

# Create internal graphql zone
resource "aws_route53_zone" "graphql" {
  name   = "internal.silverbackinsights.com."
  vpc_id = "${var.vpc_id}"
}

# Create efs file system
resource "aws_efs_file_system" "efs_ecs" {
  creation_token = "efs-ecs"
}

resource "aws_efs_mount_target" "efs_ecs_mount_target" {
  count           = 2
  file_system_id  = "${aws_efs_file_system.efs_ecs.id}"
  subnet_id       = "${element(var.subnets_private, count.index)}"
  security_groups = ["${aws_security_group.graphql.id}"]
}

resource "aws_alb" "api_alb" {
  name            = "${var.cluster_name}"
  subnets         = ["${var.subnets_public}"]
  security_groups = ["${var.ui_app_security_group_id}"]
  internal        = false
  idle_timeout    = 60
}

# Lookup cert in ACM
data "aws_acm_certificate" "san_cert" {
  domain   = "${var.domain_cert}"
  statuses = ["${var.cert_statuses}"]
}

# Create API application load balancer target group
resource "aws_alb_target_group" "api_alb_target_group" {
  name                 = "${var.cluster_name}-web"
  port                 = 8080
  protocol             = "HTTP"
  vpc_id               = "${var.vpc_id}"
  deregistration_delay = 30
}

resource "aws_alb_listener" "api_alb_https" {
  load_balancer_arn = "${aws_alb.api_alb.arn}"
  port              = "443"
  protocol          = "HTTPS"

  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "${data.aws_acm_certificate.san_cert.arn}"

  default_action {
    target_group_arn = "${aws_alb_target_group.api_alb_target_group.arn}"
    type             = "forward"
  }
}

# Create API app load balancer target group for web socket traffic (stickiness required)
resource "aws_alb_target_group" "api_ws_alb_target_group" {
  name       = "${var.cluster_name}-ws"
  port       = 8091
  protocol   = "HTTP"
  vpc_id     = "${var.vpc_id}"

  stickiness = {
    type = "lb_cookie"
  }
}

resource "aws_alb_listener_rule" "graphql_https" {
  listener_arn = "${aws_alb_listener.api_alb_https.arn}"
  priority     = 101

  action {
    target_group_arn = "${aws_alb_target_group.api_alb_target_group.arn}"
    type             = "forward"
  }

  condition {
    field  = "path-pattern"
    values = ["/graphql"]
  }
}

resource "aws_alb_listener_rule" "graphiql_https" {
  listener_arn = "${aws_alb_listener.api_alb_https.arn}"
  priority     = 102

  action {
    target_group_arn = "${aws_alb_target_group.api_alb_target_group.arn}"
    type             = "forward"
  }

  condition {
    field  = "path-pattern"
    values = ["/graphiql"]
  }
}

resource "aws_alb_listener_rule" "api_health_https" {
  listener_arn = "${aws_alb_listener.api_alb_https.arn}"
  priority     = 103

  action {
    target_group_arn = "${aws_alb_target_group.api_alb_target_group.arn}"
    type             = "forward"
  }

  condition {
    field  = "path-pattern"
    values = ["/api-health"]
  }
}

resource "aws_alb_listener_rule" "ws_https" {
  listener_arn = "${aws_alb_listener.api_alb_https.arn}"
  priority     = 100

  action {
    target_group_arn = "${aws_alb_target_group.api_ws_alb_target_group.arn}"
    type             = "forward"
  }

  condition {
    field  = "path-pattern"
    values = ["/ws"]
  }
}

# Create Autoscaling group
resource "aws_autoscaling_group" "graphql_asg" {
  name                 = "${var.cluster_name}"
  vpc_zone_identifier  = ["${var.subnets_private}"]
  availability_zones   = ["${var.availability_zones}"]
  launch_configuration = "${aws_launch_configuration.ecs_launch_config.name}"
  min_size             = "${var.min_size}"
  max_size             = "${var.max_size}"
  desired_capacity     = "${var.desired_capacity}"

  target_group_arns    = [
    "${aws_alb_target_group.api_alb_target_group.arn}",
    "${aws_alb_target_group.api_ws_alb_target_group.arn}"
  ]

  tag {
    key                 = "Name"
    value               = "${aws_ecs_cluster.ecs_cluster.name}"
    propagate_at_launch = true
  }

}
