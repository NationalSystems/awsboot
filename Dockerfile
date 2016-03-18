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




