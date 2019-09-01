

output "elb" {
  value = "${aws_elb.nubank-app-elb.dns_name}"
}