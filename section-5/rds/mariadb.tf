

provider "aws" {
  region  = "${var.region}"
  profile = "${var.profile}"
}


resource "aws_db_instance" "mariadb-inst1" {
  allocated_storage       = "100" # means 100 GB
  engine                  = "mariadb"
  engine_version          = "10.1.14"
  instance_class          = "db.t2.small"
  identifier              = "mariadb"
  name                    = "mariadb"
  username                = "guest"
  password                = "welcome1"
  db_subnet_group_name    = "${aws_db_subnet_group.mariadb-subnet-inst1-group.name}"
  parameter_group_name    = "${aws_db_parameter_group.mariadb-inst1-group.name}"
  multi_az                = "false"
  vpc_security_group_ids  = ["${aws_security_group.allow_mariadb.id}"]
  storage_type            = "gp2"
  backup_retention_period = 30
  availability_zone       = "${data.aws_subnet.main-private-1.availability_zone}"
  tags = {
    Name = "mariadb-instance"
  }
}


resource "aws_db_parameter_group" "mariadb-inst1-group" {
  name        = "mariadb-inst1"
  family      = "mariadb10.1"
  description = "MariaDB paramters group"

  parameter {
    name  = "max_allowed_packet"
    value = "16777216"
  }
}


resource "aws_db_subnet_group" "mariadb-subnet-inst1-group" {

  name        = "mariadb-subnet"
  description = "RDS subnet group"
  subnet_ids  = ["${data.aws_subnet.main-private-1.id}", "${data.aws_subnet.main-private-2.id}"]

}


resource "aws_security_group" "allow_mariadb" {
  vpc_id      = "${data.aws_vpc.main_vpc.id}"
  name        = "allow-mariadb"
  description = "allow-mariadb"

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = ["${data.aws_security_group.allow-ssh-maridb.id}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    self        = true
  }

  tags = {
    Name = "allow-maridb"
  }

}
