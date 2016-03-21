#!/usr/bin/env sh

arg=$1
echo arg is $arg
source setenv.sh $awsprofile $awsuser $appname $dnsdomain && terraform $arg
