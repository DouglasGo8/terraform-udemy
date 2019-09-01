

variable "profile" {
  default = "default"
}

variable "region" {
  default = "us-east-1"
}


variable "AMIS" {
  type = "map"
  default = {
    us-east-1 = "ami-13be55e"
    us-east-2 = "ami-06b94666"
  }
}

