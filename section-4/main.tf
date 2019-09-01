
provider "aws" {
  region  = "${var.region}"
  profile = "${var.profile}"
}

resource "aws_instance" "t2-micro-inst" {
  ami           = "${lookup(var.AMIS, var.region)}"
  instance_type = "t2.micro"
}
