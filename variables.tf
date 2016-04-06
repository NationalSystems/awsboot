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
    us-west-1 = "ami-1b0f7d7b"
    us-west-2 = "ami-c229c0a2"
    us-east-1 = "ami-8fcee4e5" 
    eu-west-1 = "ami-31328842"
    eu-central-1 = "ami-e2df388d"
    ap-northeast-1 = ""
    ap-northeast-2 = ""
    ap-southeast-1 = ""
    ap-southeast-2 = ""
    sa-east-1 = ""
    cn-north-1 = ""
    us-gov-west-1 = ""
  }
}
