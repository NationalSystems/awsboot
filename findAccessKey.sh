#!/usr/bin/env sh
userName=$1
aws --profile $userName iam list-access-keys --user-name $userName --output text --query AccessKeyMetadata[*].AccessKeyId
