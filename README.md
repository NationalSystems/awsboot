[![Build Status](https://travis-ci.org/joshuacalloway/awsboot.svg?branch=master)](https://travis-ci.org/joshuacalloway/awsboot)

# awsboot

This is a simple project that allows developers to add Jenkins CI, launch their project into AWS ec2.

# see demo, cloning a facebook react github project and launching it into AWS with jenkins CI

[![Demo CountPages alpha](http://img.youtube.com/vi/RA11JGz8fSQ/default.jpg)](https://www.youtube.com/watch?v=RA11JGz8fSQ)

Instructions
### 1. build a docker image by adding Dockerfile to your project

##### Dockerfile
```
from joshuacalloway/awsboot
env awsuser jcalloway
env appname myapp
env dnsdomain mopedjc.com
```      
        
##### Build Docker image     
      docker build -t myapp .
      docker run -v ~/.aws:/root/.aws myapp apply
    

### 2. Configure jenkins to build your project
      open chrome and visit  "http://myapp.mopedjc.com:8080"
      configure jenkins to build your project
      user password for jenkins is admin/awsbootPassw0rd1 ( default )

