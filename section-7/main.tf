
provider "aws" {
  region  = "${var.region}"
  profile = "${var.profile}"
}

resource "aws_instance" "t2-micro-inst-jenkins" {
  ami                    = "${lookup(var.AMIS, var.region)}"
  subnet_id              = "${data.aws_subnet.main-public-1.id}"
  vpc_security_group_ids = ["${data.aws_security_group.allow-ssh.id}"]
  instance_type          = "t2.small"
  key_name               = "${aws_key_pair.main-public-key.key_name}"

  user_data = "${data.template_cloudinit_config.cloudinit-jenkins.rendered}"
}

resource "aws_ebs_volume" "ebs-volume-jenkins" {
  availability_zone = "us-east-1"
  size              = 20
  type              = "gp2"
  tags = {
    Name = "extra Volume data"
  }
}

resource "aws_volume_attachment" "ebs-volume-jenkins-attachment" {
  device_name = "${var.INSTANCE_DEVICE_NAME}"
  volume_id   = "${aws_ebs_volume.ebs-volume-jenkins.id}"
  instance_id = "${aws_instance.t2-micro-inst-jenkins.id}"
}

resource "aws_key_pair" "main-public-key" {
  key_name   = "main-public-key"
  public_key = "${file("../.secret/key.pub")}"
}

resource "aws_instance" "t2-micro-inst-node-app" {
  count                  = "${var.APP_INSTANCE_COUNT}"
  ami                    = "${lookup(var.AMIS, var.region)}"
  subnet_id              = "${data.aws_subnet.main-public-1.id}"
  vpc_security_group_ids = ["${data.aws_security_group.allow-ssh.id}"]
  instance_type          = "t2.micro"
  key_name               = "${aws_key_pair.main-public-key.key_name}"

}
