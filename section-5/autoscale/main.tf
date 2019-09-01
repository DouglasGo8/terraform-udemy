

provider "aws" {
  region  = "${var.region}"
  profile = "${var.profile}"
}


resource "aws_launch_configuration" "auto-scale-sample" {
  name_prefix     = "auto-scale-sample"
  image_id        = "${lookup(var.AMIS, var.region)}"
  instance_type   = "t2.micro"
  key_name        = "${aws_key_pair.main-public-key.key_name}"
  security_groups = ["${data.aws_security_group.mysg-instance.id}"]
  user_data       = "#!/bin/bash\napt-get update\napt-get -y install nginx\nsudo systemctl start nginx\nMYIP=`ifconfig | grep 'addr:10' | awk '{ print $2 }' | cut -d ':' -f2`\necho 'this is: '$MYIP > /var/www/html/index.html"
  lifecycle { create_before_destroy = true }
}


resource "aws_autoscaling_group" "auto-scale-sample-group" {

  name                      = "auto-scale-sample-group"
  vpc_zone_identifier       = ["${data.aws_subnet.main-public-1.id}", "${data.aws_subnet.main-public-2.id}"]
  launch_configuration      = "${aws_launch_configuration.auto-scale-sample.name}"
  min_size                  = 1
  max_size                  = 2
  health_check_grace_period = 300
  health_check_type         = "ELB"
  # health_check_type         = "EC2"
  force_delete   = true
  load_balancers = ["${aws_elb.main-classic-elb.id}"]
  tag {
    key                 = "Name"
    value               = "ec2 instance"
    propagate_at_launch = true
  }

}

resource "aws_autoscaling_policy" "auto-scale-policy-sample" {

  name                   = "auto-scale-policy-sample"
  autoscaling_group_name = "${aws_autoscaling_group.auto-scale-sample-group.name}"
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = "1"
  cooldown               = "300"
  policy_type            = "SimpleScaling"

}


resource "aws_cloudwatch_metric_alarm" "cloudwath-cpu-metric" {
  alarm_name          = "cloudwath-cpu-metric"
  alarm_description   = "cloudwath-cpu-metric"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "30"

  dimensions = {
    "AutoScalinggroupName" = "${aws_autoscaling_group.auto-scale-sample-group.name}"
  }

  actions_enabled = true
  alarm_actions   = ["${aws_autoscaling_policy.auto-scale-policy-sample.arn}"]

}

resource "aws_elb" "main-classic-elb" {
  name            = "main-classic-elb"
  subnets         = ["${data.aws_subnet.main-public-1.id}", "${data.aws_subnet.main-public-2.id}"]
  security_groups = ["${data.aws_security_group.elb-sg.id}"]
  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 20
    target              = "HTTP:80/"
    interval            = 60
  }

  cross_zone_load_balancing   = true
  connection_draining         = true
  connection_draining_timeout = 400
  tags = {
    Name = "my-elb"
  }

}


resource "aws_key_pair" "main-public-key" {
  key_name   = "main-public-key"
  public_key = "${file("../../.secret/key.pub")}"
}
