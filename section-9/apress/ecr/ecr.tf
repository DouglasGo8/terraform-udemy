
provider "aws" {
  region  = "${var.region}"
  profile = "${var.profile}"
}

resource "aws_ecr_repository" "apress-repo" {
    name = "apress-repo"
    image_tag_mutability = "MUTABLE"
    image_scanning_configuration  {
        scan_on_push = true
    }
}

resource "aws_ecr_lifecycle_policy" "apress-repo-lifecycle" {
  repository = "${aws_ecr_repository.apress-repo.name}"
  policy = <<EOF
{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Expire images older than 10 days",
            "selection": {
                "tagStatus": "any",
                "countType": "sinceImagePushed",
                "countUnit": "days",
                "countNumber": 10
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
}