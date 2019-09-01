

resource "aws_security_group" "ecs-nubank-app-sg" {
  name        = "ecs-nubank-app-sg"
  vpc_id      = "${data.aws_vpc.main_vpc.id}"
  description = "Security group for ecs"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    self        = true
  }

  ingress {
    from_port   = 32666
    to_port     = 32666
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ECS Nubank app"
  }

}


resource "aws_security_group" "elb-nubank-app-sg" {
  name        = "elb-nubank-app-sg"
  vpc_id      = "${data.aws_vpc.main_vpc.id}"
  description = "Security group for elb"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    self        = true
  }

  ingress {
    from_port   = 32666
    to_port     = 32666
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ELB Nubank app"
  }

}
