#!/usr/bin/env sh

arg=$1
echo arg is $arg
source setenv.sh $aws_iam $appname $dnsdomain && terraform $arg
