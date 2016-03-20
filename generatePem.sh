#!/usr/bin/env sh

appname=$1

aws ec2 delete-key-pair --key-name --region us-west-2 $appname
aws ec2 create-key-pair --key-name $appname --output json --region us-west-2 | jq -r ".KeyMaterial" > ~/.aws/${appname}.pem
