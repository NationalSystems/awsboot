from governmentpaas/terraform
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
#volume /root/.ssh

run mkdir /root/.ssh
onbuild run cd /tmp && \
            ssh-keygen -f id_rsa -t rsa -N '' && \
            chmod 400 id_rsa

onbuild run echo "please save this deployment key to your project on github or bitbucket"
onbuild run cat /tmp/id_rsa.pub
onbuild run mv /tmp/id_rsa /root/.ssh/id_rsa
onbuild run mv /tmp/id_rsa.pub /root/.ssh/id_rsa.pub

onbuild env dnsdomain $dnsdomain

# TODO take out appname variable.  We can figure this out.
onbuild run echo "appname is $appname"
onbuild env awsprofile ${awsprofile:-default}
onbuild env awsuser $awsuser
onbuild env awsinstancetype ${awsinstancetype:-t2.micro}
onbuild env awsregion ${awsregion:-us-west-2}

onbuild run echo hello, this is $appname
workdir /app

onbuild run /app/verifyRequiredEnvironment.sh



## for debug purposes, uncomment below
#entrypoint ["sh"]
entrypoint ["./execute.sh"]
#entrypoint ["./debug.sh"]
CMD ["plan"]








