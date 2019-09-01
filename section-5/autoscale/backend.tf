terraform {
  backend "s3" {
    bucket = "devops-ddb"
    key    = "terraform/section-5/autoscale"
    region = "us-east-1"
  }
}
