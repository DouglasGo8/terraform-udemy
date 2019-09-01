terraform {
  backend "s3" {
    bucket = "devops-ddb"
    key    = "terraform/section-8/nubank-app"
    region = "us-east-1"
  }
}
