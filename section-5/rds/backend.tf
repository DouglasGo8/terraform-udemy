terraform {
  backend "s3" {
    bucket = "devops-ddb"
    key    = "terraform/section-5/rds"
    region = "us-east-1"
  }
}
