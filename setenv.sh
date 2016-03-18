#!/usr/bin/env sh

export PATH=$(pwd):$PATH
export TF_VAR_aws_access_key=$(findAccessKey.sh awsboot)
export TF_VAR_aws_secret_key=$(findSecretKey.sh $TF_VAR_aws_access_key)
export AWS_ACCESS_KEY_ID=$(findAccessKey.sh awsboot)
export AWS_SECRET_ACCESS_KEY=$(findSecretKey.sh $TF_VAR_aws_access_key)
