terraform {
  backend "s3" {
    bucket = "devops-ddb"
    key    = "terraform/section-7/ec2"
    region = "us-east-1"
  }
}
