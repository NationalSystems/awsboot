
resource "aws_subnet" "awsboot" {
  vpc_id = "${aws_vpc.awsboot.id}"
  cidr_block = "10.1.2.0/28"
  tags {
    Provisioned = "awsboot"
  }
}
