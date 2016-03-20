#!/usr/bin/env sh
accessKey=$1
awk "/$accessKey/{getline; print}" ~/.aws/credentials | awk -F' = ' '{print $2}'

