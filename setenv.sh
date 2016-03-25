#!/usr/bin/env sh

awsprofile=${awsprofile:-default}
awsuser=${awsuser}
appname=${appname:-awsboot}
awsregion=${awsregion:-us-west-2}

export PATH=$(pwd):$PATH
export TF_VAR_aws_access_key=$(findAccessKey.sh $awsprofile $awsuser)
export TF_VAR_aws_secret_key=$(findSecretKey.sh $TF_VAR_aws_access_key)
export TF_VAR_appname=$appname
export TF_VAR_aws_region=$awsregion

export TF_VAR_dnsdomain=$dnsdomain
export TF_VAR_awsinstancetype=${awsinstancetype:-t2.micro}
./generatePem.sh $appname
export TF_VAR_awspem=`cat ~/.aws/${TF_VAR_appname}.pem`
export TF_VAR_aws_route53_zone_id=`aws --profile $awsprofile route53 list-hosted-zones-by-name \
                   --dns-name $TF_VAR_dnsdomain --query HostedZones[0].Id | \
                    sed 's/\/hostedzone\///' | sed 's/"//g'` 
chmod 400 ~/.aws/${TF_VAR_appname}.pem
