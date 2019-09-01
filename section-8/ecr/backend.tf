terraform {
  backend "s3" {
    bucket = "devops-ddb"
    key    = "terraform/section-8/ecr"
    region = "us-east-1"
  }
}
