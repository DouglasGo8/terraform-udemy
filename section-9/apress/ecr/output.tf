
output "appres-deploy-repo-URL" {
  value = "${aws_ecr_repository.apress-repo.repository_url}"
}
