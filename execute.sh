#!/usr/bin/env sh

arg=$1
#echo arg is $arg
#echo "dir is $(pwd) am running sed for ${appname}"
sed -i -- "s/awsboot/${appname}/g" *.tf

source setenv.sh && terraform $arg
