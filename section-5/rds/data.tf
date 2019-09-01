
data "aws_vpc" "main_vpc" {
  id = "vpc-0dd2e73c1706822bb"
}

data "aws_subnet" "main-private-1" {
  id = "subnet-0843683a20c2de75e"
}

data "aws_subnet" "main-private-2" {
  id = "subnet-0f2d8210d2e3b12bb"
}

data "aws_security_group" "allow-ssh-maridb" {
  id = "sg-011d1d96d84fd78a9"
}