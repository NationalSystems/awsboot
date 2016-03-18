from governmentpaas/terraform

RUN \
	mkdir -p /aws && \
	apk -Uuv add groff less python py-pip && \
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

#env AWS_ACCESS_KEY_ID needOne
#env AWS_SECRET_ACCESS_KEY needOne
env AWS_DEFAULT_REGION us-west-2

onbuild ARG AWS_ACCESS_KEY_ID=needOne
onbuild ENV AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID

onbuild ARG AWS_SECRET_ACCESS_KEY=needOne
onbuild ENV AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY

onbuild ARG AWS_KEY_PAIR=needOne
onbuild ENV AWS_KEY_PAIR=$AWS_KEY_PAIR

onbuild run cd /tmp && aws ec2 create-key-pair --key-name $AWS_KEY_PAIR --region us-west-2 > /tmp/${AWS_KEY_PAIR}.pem
onbuild run mv /tmp/$AWS_KEY_PAIR.pem /root/.ssh/${AWS_KEY_PAIR}.pem
onbuild run chmod 400 /root/.ssh/${AWS_KEY_PAIR}.pem 





