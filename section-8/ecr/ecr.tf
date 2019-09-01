
provider "aws" {
  region  = "${var.region}"
  profile = "${var.profile}"
}

resource "aws_ecr_repository" "nubank-check-balance-app" {
  name = "nubank-check-balance-app"
}
