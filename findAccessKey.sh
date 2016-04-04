#!/usr/bin/env sh
awsprofile=$1
awsuser=$2
accesskeys=$(aws --profile $awsprofile iam list-access-keys --user-name $awsuser --output text --query AccessKeyMetadata[*].AccessKeyId)

theAccessKey=""
for accesskey in $accesskeys; do
   theAccessKey=${theAccessKey}$(grep -A 2 $awsprofile ~/.aws/credentials | grep $accesskey | awk '{print $3}')
done

echo $theAccessKey
