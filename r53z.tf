
resource "aws_route53_record" "awsboot" {
  zone_id = "${var.aws_route53_zone_id}"
  name = "${var.appname}.${var.dnsdomain}"
  type = "CNAME"
    ttl = "5"
  weight = 10
  set_identifier = "${var.appname}"
  records = ["${aws_instance.awsboot.public_dns}"]
}

