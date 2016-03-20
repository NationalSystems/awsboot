#!/usr/bin/env sh

profile=$1
export PATH=$(pwd):$PATH
export TF_VAR_aws_access_key=$(findAccessKey.sh jcalloway)
export TF_VAR_aws_secret_key=$(findSecretKey.sh $TF_VAR_aws_access_key)
