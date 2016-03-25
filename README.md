# awsboot

This is a simple project that allows developers to add Jenkins CI, launch their project into AWS ec2.

Instructions
   1. Add Dockerfile to your project
     ```bash
      echo "from joshuacalloway/awsboot" > Dockerfile
      echo "env awsuser jcalloway" >> Dockerfile
      echo "env appname myapp" >> Dockerfile
      echo "env dnsdomain mopedjc.com" >> Dockerfile
      docker build -t myapp .
      docker run -v ~/.aws:/root/.aws myapp apply

      open chrome and visit  "http://myapp.mopedjc.com:8080"
      configure jenkins to build your project
      user password for jenkins is admin/awsbootPassw0rd1 ( default )
    ```

see video for how we cloned a facebook react project on github and launched it into aws

[![Demo CountPages alpha](http://img.youtube.com/vi/RA11JGz8fSQ/default.jpg)](https://www.youtube.com/watch?v=RA11JGz8fSQ)
