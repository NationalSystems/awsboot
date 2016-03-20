#!/usr/bin/env sh

aws ec2 delete-key-pair --key-name --region us-west-2 awsboot
aws ec2 create-key-pair --key-name awsboot --region us-west-2 > /root/.aws/awsboot.pem
