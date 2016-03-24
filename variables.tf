variable "appname" {} 
variable "awspem" {} 
variable "awsinstancetype" {}
variable "aws_route53_zone_id" {}
variable "dnsdomain" {}

variable "aws_secret_key" {}
variable "aws_access_key" {}
variable "aws_region" {}
variable "amis" {
  default = {
    eu-west-1 = "ami-e1398992"
    us-west-2 = "ami-c229c0a2"
    us-east-1 = "ami-8fcee4e5" 
  }
}
