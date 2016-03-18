provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region = "us-west-2"
}

resource "aws_instance" "bootdemo" {
    ami = "${lookup(var.amis, var.aws_region)}"
    instance_type = "t2.micro"
    tags {
      Name = "${var.appname}"
      Provisioned = "awsboot"
    }
    vpc_security_group_ids = ["${aws_security_group.allow_all.id}"]
    subnet_id = "${aws_subnet.bootdemo.id}"
    key_name = "${var.aws_key_name}"
    associate_public_ip_address = true
    user_data = "${file("base-config.txt")}"
    connection {
      user = "ec2-user"
      private_key = "${file("~/.ssh/${var.appname}.pem")}"
    }
   provisioner "local-exec" {
     command = "docker run -d -v $(pwd)/.ssh:/root/.ssh kagux/ssh-keygen"
   }
   provisioner "file" {
        source = ".ssh"
        destination = "/home/ec2-user"
    }
    provisioner "remote-exec" {
        script = "waitForCloudInitDone.sh"
    }
    provisioner "remote-exec" {
        inline = [
          "ssh-keyscan github.com > ~/.ssh/known_hosts",
          "git clone https://github.com/joshuacalloway/jenkins.git",
          "cp -R /home/ec2-user/.ssh /home/ec2-user/jenkins/.ssh",
          "cd /home/ec2-user/jenkins && docker build -t jenkins .",
         ]
    }
    provisioner "remote-exec" {
        script = "startJenkins.sh"
    }
    
    tags {
       Provisioned = "awsboot"
    }
  
}
