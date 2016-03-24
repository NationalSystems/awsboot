#!/usr/bin/env sh

awsprofile=$1
appname=$2

rm -rf ~/.aws/${appname}.pem

aws --profile $awsprofile ec2 delete-key-pair --key-name $appname
aws --profile $awsprofile ec2 create-key-pair --key-name $appname --output json | jq -r ".KeyMaterial" > ~/.aws/${appname}.pem
