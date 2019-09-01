

output "jenkins-ip" {
  value = ["${aws_instance.t2-micro-inst-jenkins.*.public_ip}"]
}

output "app-ip" {
  value = ["${aws_instance.t2-micro-inst-node-app.*.public_ip}"]
}
