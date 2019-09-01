

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

