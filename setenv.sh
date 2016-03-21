#!/usr/bin/env sh

profileName=$1
userName=$2
appname=$3
dnsname=$4
export PATH=$(pwd):$PATH
export TF_VAR_aws_access_key=$(findAccessKey.sh $profileName $userName)
export TF_VAR_aws_secret_key=$(findSecretKey.sh $TF_VAR_aws_access_key)
export TF_VAR_appname=$appname

export TF_VAR_dnsdomain=$dnsdomain
./generatePem.sh $TF_VAR_appname
export TF_VAR_awsboot_pem=`cat ~/.aws/${TF_VAR_appname}.pem` 
export TF_VAR_aws_route53_zone_id=`aws route53 list-hosted-zones-by-name \
                   --dns-name $TF_VAR_dnsdomain --query HostedZones[0].Id | \
                    sed 's/\/hostedzone\///'` && \
chmod 400 ~/.aws/${TF_VAR_appname}.pem
