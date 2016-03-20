#!/usr/bin/env sh

profile=$1
export PATH=$(pwd):$PATH
export TF_VAR_aws_access_key=$(findAccessKey.sh $profile)
export TF_VAR_aws_secret_key=$(findSecretKey.sh $TF_VAR_aws_access_key)

