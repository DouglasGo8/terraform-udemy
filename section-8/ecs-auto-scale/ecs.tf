
provider "aws" {
  region  = "${var.region}"
  profile = "${var.profile}"
}

resource "aws_ecs_cluster" "nubank-app-cluster" {
  name = "nubank-app-cluster"
}

resource "aws_launch_configuration" "ecs-nubank-app-launch-config" {
  name_prefix          = "ecs-nubank-app-launch-config"
  image_id             = "${lookup(var.ECS_AMIS, var.region)}"
  instance_type        = "${var.ECS_INSTANCE_TYPE}"
  key_name             = "${aws_key_pair.main-public-key.key_name}"
  iam_instance_profile = "${aws_iam_instance_profile.ecs-ec2-nubank-app-role.id}"
  security_groups      = ["${aws_security_group.ecs-nubank-app-sg.id}"]
  user_data            = "#!/bin/bash\necho 'ECS_CLUSTER=nubank-app-cluster' > /etc/ecs/ecs.config\nstart ecs"
  lifecycle { create_before_destroy = true }
}


resource "aws_autoscaling_group" "ecs-nubank-app-autoscaling" {
  name                 = "ecs-nubank-app-autoscaling"
  vpc_zone_identifier  = ["${data.aws_subnet.main-public-1.id}", "${data.aws_subnet.main-public-2.id}"]
  launch_configuration = "${aws_launch_configuration.ecs-nubank-app-launch-config.name}"
  min_size             = 1
  max_size             = 2
  tag {
    key                 = "ecs-nubank-app-autoscaling"
    value               = "ecs-nubank-app-autoscaling-container"
    propagate_at_launch = true
  }

}


resource "aws_key_pair" "main-public-key" {
  key_name   = "main-public-key"
  public_key = "${file("../../.secret/key.pub")}"
}

