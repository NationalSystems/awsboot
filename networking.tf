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

resource "aws_security_group" "allow_all" {
  name = "allow_all"
  description = "Allow all inbound traffic"
  vpc_id = "${aws_vpc.awsboot.id}"
  ingress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }
  tags {
     Provisioned = "awsboot"
  }
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
  name = "${var.appname}.${var.aws_route53_dns}"
  type = "CNAME"
    ttl = "5"
 
  weight = 10
  set_identifier = "${var.appname}"
  records = ["${aws_instance.awsboot.public_dns}"]
}

