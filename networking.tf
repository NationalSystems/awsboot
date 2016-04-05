resource "aws_internet_gateway" "awsboot" {
    vpc_id = "${aws_vpc.awsboot.id}"

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


 
