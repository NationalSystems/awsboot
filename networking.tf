resource "aws_internet_gateway" "awsboot" {
    vpc_id = "${aws_vpc.awsboot.id}"

    tags {
        Provisioned = "awsboot"
    }
}

resource "aws_vpc" "awsboot" {
  cidr_block = "10.1.2.0/28"
  enable_dns_support = "true"
  enable_dns_hostnames = "true"
  tags {
     Provisioned = "awsboot"
  }
}

resource "aws_route_table" "awsboot" {
  vpc_id = "${aws_vpc.awsboot.id}"
  route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.awsboot.id}"
    }

    tags {
        Provisioned = "awsboot"
    }
}
resource "aws_main_route_table_association" "awsboot" {
  vpc_id = "${aws_vpc.awsboot.id}"
  route_table_id = "${aws_route_table.awsboot.id}"
}

resource "aws_subnet" "awsboot" {
  vpc_id = "${aws_vpc.awsboot.id}"
  cidr_block = "10.1.2.0/28"
  tags {
    Provisioned = "awsboot"
  }
}

resource "aws_route53_record" "awsboot" {
  zone_id = "${var.aws_route53_zone_id}"
  name = "${var.appname}.${var.dnsdomain}"
  type = "CNAME"
    ttl = "5"
 
  weight = 10
  set_identifier = "${var.appname}"
  records = ["${aws_instance.awsboot.public_dns}"]
}

