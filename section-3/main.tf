provider "aws" {
    region = "us-east-1"
    profile = "default"
}


resource "aws_instance" "t2-micro-inst" {
    ami = "ami-0d729a60"
    instance_type = "t2.micro"
}
