

data "aws_vpc" "main_vpc" {
  id = "vpc-0137865cbbc2ef167"
}

data "aws_subnet" "main-public-1" {
  id = "subnet-0d9c44d9cf947727a"
}

data "aws_subnet" "main-public-2" {
  id = "subnet-005c07d31c8157dda"
}
