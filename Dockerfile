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

run mkdir /awsboot
add . /awsboot

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

onbuild env TF_VAR_appname bootdemo

workdir /awsboot
CMD source setenv.sh && \
    ./generatePem.sh && \
    chmod 400 ~/.aws/awsboot.pem && \
    terraform apply






