from governmentpaas/terraform
RUN apk add --update tzdata
RUN cp /usr/share/zoneinfo/CST6CDT /etc/localtime


RUN \
	mkdir -p /aws && \
	apk -Uuv add jq groff less python py-pip && \
	pip install awscli && \
	apk --purge -v del py-pip && \
	rm /var/cache/apk/*


volume /src
onbuild add . /src

volume /app
add . /app

volume /root/.aws
#volume /root/.ssh

run mkdir /root/.ssh
onbuild run cd /tmp && \
            ssh-keygen -f id_rsa -t rsa -N '' && \
            chmod 400 id_rsa

onbuild run echo "please save this deployment key to your project on github or bitbucket"
onbuild run cat /tmp/id_rsa.pub
onbuild run mv /tmp/id_rsa /root/.ssh/id_rsa
onbuild run mv /tmp/id_rsa.pub /root/.ssh/id_rsa.pub

onbuild env TF_VAR_dnsdomain needIt
onbuild env TF_VAR_appname needIt
onbuild env aws_iam needIt

workdir /app

onbuild run sed -i -- "s/awsboot/${TF_VAR_appname}/g" *


## for debug purposes, uncomment below
CMD source setenv.sh $aws_iam && \
    ./generatePem.sh $TF_VAR_appname && \
    export TF_VAR_awsboot_pem=`cat ~/.aws/${TF_VAR_appname}.pem` && \
    export TF_VAR_aws_route53_zone_id=`aws route53 list-hosted-zones-by-name \
                   --dns-name $TF_VAR_dnsdomain --query HostedZones[0].Id | \
                    sed 's/\/hostedzone\///'` && \
#    export TF_VAR_myvariable=HelpMe && \
    chmod 400 ~/.aws/${TF_VAR_appname}.pem && \
#    env  \
#    cat ~/.aws/${TF_VAR_appname}.pem
    terraform apply






