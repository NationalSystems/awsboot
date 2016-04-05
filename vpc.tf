
resource "aws_vpc" "awsboot" {
  cidr_block = "10.1.2.0/28"
  enable_dns_support = "true"
  enable_dns_hostnames = "true"
  tags {
     Provisioned = "awsboot"
  }
}
