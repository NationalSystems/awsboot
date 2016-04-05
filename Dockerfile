from joshuacalloway/terraform
#from governmentpaas/terraform
RUN apk add --update tzdata && cp /usr/share/zoneinfo/CST6CDT /etc/localtime

RUN mkdir -p /aws && \
	apk -Uuv add jq groff less python py-pip && \
	pip install awscli && \
	apk --purge -v del py-pip && \
	rm /var/cache/apk/*

volume /src
onbuild add . /src

volume /app
add . /app

volume /root/.aws

# TODO make /root/.ssh a volume directory
#      for security reasons
volume /root/.ssh

onbuild env dnsdomain $dnsdomain

# TODO take out appname variable.  We can figure this out.
onbuild run echo "appname is $appname"
onbuild env appname ${appname:-awsboot}
onbuild env awsprofile ${awsprofile:-default}
onbuild env awsuser $awsuser
onbuild env awsinstancetype ${awsinstancetype:-t2.micro}
onbuild env awsregion ${awsregion:-us-west-2}

onbuild run echo hello, this is $appname
workdir /app
onbuild copy . /tmp
onbuild run mv /tmp/*.tf /app/ || echo "who cares" 
onbuild run mv /tmp/*.tfvars /app/ || echo "who cares"


onbuild run /app/verifyRequiredEnvironment.sh

entrypoint ["./execute.sh"]
CMD ["plan"]








