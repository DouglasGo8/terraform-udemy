
data "aws_security_group" "allow-ssh" {
  id = "sg-0b6d8ea9dcabe226e"
}


data "aws_subnet" "main-public-1" {
  id = "subnet-0d9c44d9cf947727a"
}


