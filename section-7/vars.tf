

variable "profile" {
  default = "default"
}

variable "region" {
  default = "us-east-1"
}


variable "AMIS" {
  type = "map"
  default = {
    us-east-1 = "ami-026c8acd92718196b"
  }
}

variable "INSTANCE_DEVICE_NAME" {
  default = "/dev/xvdh"
}

variable "JENKINS_VERSION" {
  default = "2.121.2"
}

variable "APP_INSTANCE_COUNT" {
  default = "0"
}

variable "TERRAFORM_VERSION" {
  default = "0.12.2"
}