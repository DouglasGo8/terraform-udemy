terraform {
  backend "s3" {
    bucket = "devops-ddb"
    key    = "terraform/section-5/vpc"
    region = "us-east-1"
  }
}
