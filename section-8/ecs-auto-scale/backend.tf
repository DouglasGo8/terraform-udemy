terraform {
  backend "s3" {
    bucket = "devops-ddb"
    key    = "terraform/section-8/ecs-auto-scale"
    region = "us-east-1"
  }
}
