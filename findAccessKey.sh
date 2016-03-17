#!/usr/bin/env bash
userName=$1
aws iam list-access-keys --user-name $userName --output text --query AccessKeyMetadata[*].AccessKeyId
