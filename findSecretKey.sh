#!/usr/bin/env sh
accessKey=$1
grep $accessKey ~/.aws/map  | awk -F' -> ' '{print $2}'
