
provider "aws" {
  region  = "${var.region}"
  profile = "${var.profile}"
}


resource "aws_ecs_task_definition" "nubank-app-task-def" {
  family                = "nubank-app"
  container_definitions = "${data.template_file.nubank-app-task-def-template.rendered}"

}

resource "aws_elb" "nubank-app-elb" {
  name = "nubank-app-elb"

  listener {
    instance_port     = 32666
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 3
    unhealthy_threshold = 3
    timeout             = 30
    target              = "HTTP:32666/api/greeting/sayHello"
    interval            = 60
  }

  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  subnets         = ["${data.aws_subnet.main-public-1.id}", "${data.aws_subnet.main-public-2.id}"]
  security_groups = ["${data.aws_security_group.elb-nubank-app-sg.id}"]

  tags = {
    Name = "nubank-app-elb"
  }


}

resource "aws_ecs_service" "nubank-app-service" {
  name            = "nubank-app-service"
  cluster         = "${data.aws_ecs_cluster.nubank-app-cluster.id}"
  task_definition = "${aws_ecs_task_definition.nubank-app-task-def.arn}"
  desired_count   = 1
  iam_role        = "${aws_iam_role.ecs-service-nubank-app-role.arn}"
  depends_on      = ["aws_iam_policy_attachment.ecs-service-nubank-app-attach1"]

  load_balancer {
    elb_name       = "${aws_elb.nubank-app-elb.name}"
    container_name = "nubank-app"
    container_port = 32666
  }
  lifecycle { ignore_changes = ["task_definition"] }


}

resource "aws_iam_role" "ecs-service-nubank-app-role" {
  name               = "ecs-service-nubank-app-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ecs.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_policy_attachment" "ecs-service-nubank-app-attach1" {
  name = "ecs-service-nubank-app-attach1"
  roles = ["${aws_iam_role.ecs-service-nubank-app-role.name}"]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceRole"

}
