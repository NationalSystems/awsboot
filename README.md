[![Build Status](https://travis-ci.org/joshuacalloway/awsboot.svg?branch=master)](https://travis-ci.org/joshuacalloway/awsboot)

# awsboot

This is a simple project that allows developers to add Jenkins CI, launch their project into AWS ec2.

# see demo, cloning a facebook react github project and launching it into AWS with jenkins CI

[![Demo CountPages alpha](http://img.youtube.com/vi/RA11JGz8fSQ/default.jpg)](https://www.youtube.com/watch?v=RA11JGz8fSQ)

Instructions
### 1. build a docker image by adding Dockerfile to your project
     ```bash
      echo "from joshuacalloway/awsboot" > Dockerfile
      echo "env awsuser jcalloway" >> Dockerfile
      echo "env appname myapp" >> Dockerfile
      echo "env dnsdomain mopedjc.com" >> Dockerfile
      docker build -t myapp .
      docker run -v ~/.aws:/root/.aws myapp apply
     ```

### 2. Configure jenkins to build your project
     ```bash
      open chrome and visit  "http://myapp.mopedjc.com:8080"
      configure jenkins to build your project
      user password for jenkins is admin/awsbootPassw0rd1 ( default )
    ```

