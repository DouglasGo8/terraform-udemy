
data "aws_security_group" "elb-sg" {
  id = "sg-00b416059597908e7"
}


data "aws_security_group" "mysg-instance" {
  id = "sg-0b6d8ea9dcabe226e"
}


data "aws_subnet" "main-public-1" {
  id = "subnet-0d9c44d9cf947727a"
}

data "aws_subnet" "main-public-2" {
  id = "subnet-005c07d31c8157dda"
}
