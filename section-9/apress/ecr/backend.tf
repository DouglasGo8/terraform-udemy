terraform {
  backend "s3" {
    bucket = "devops-ddb"
    key    = "terraform/section-9/apress/ecr"
    region = "us-east-1"
  }
}
