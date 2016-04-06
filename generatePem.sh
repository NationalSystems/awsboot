#!/usr/bin/env sh

appname=$1
cp ~/.aws/${appname}.pem{,.bak}

aws --profile $awsprofile ec2 delete-key-pair --key-name $appname
aws --profile $awsprofile ec2 create-key-pair --key-name $appname --output json | jq -r ".KeyMaterial" > ~/.aws/${appname}.pem
