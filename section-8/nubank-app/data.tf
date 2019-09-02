

data "template_file" "nubank-app-task-def-template" {
  template = "${file("./templates/app.json.tpl")}"
  vars = {
    REPOSITORY_URL = "501317491826.dkr.ecr.us-east-1.amazonaws.com/nubank-check-balance-app"
  }
}


data "aws_subnet" "main-public-1" {
  id = "subnet-0d9c44d9cf947727a"
}

data "aws_subnet" "main-public-2" {
  id = "subnet-005c07d31c8157dda"
}

data "aws_security_group" "elb-nubank-app-sg" {
  # ELB Security group (WARNING id bellow was removed)
  id = "sg-0c01d63feec0bca0e"
}

data "aws_ecs_cluster" "nubank-app-cluster" {
  cluster_name = "nubank-app-cluster"
}
