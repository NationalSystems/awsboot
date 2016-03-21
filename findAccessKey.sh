#!/usr/bin/env sh
awsprofile=$1
awsuser=$2
aws --profile $awsprofile iam list-access-keys --user-name $awsuser --output text --query AccessKeyMetadata[*].AccessKeyId
