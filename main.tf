provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region = "${var.aws_region}"
}

resource "aws_instance" "awsboot" {
    ami = "${lookup(var.amis, var.aws_region)}"
    instance_type = "${var.awsinstancetype}"
    tags {
      Name = "${var.appname}"
      Provisioned = "awsboot"
    }
    vpc_security_group_ids = ["${aws_security_group.awsboot.id}"]
    subnet_id = "${aws_subnet.awsboot.id}"
    key_name = "${var.appname}"
    associate_public_ip_address = true
    user_data = "${file("base-config.txt")}"
    volume_size = 32
    connection {
      user = "ec2-user"
      private_key = "${file("~/.aws/awsboot.pem")}"
    }
   provisioner "file" {
        source = "~/.ssh"
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
          "cd /home/ec2-user/jenkins && ./startJenkins.sh"
         ]
    }
    
    tags {
       Provisioned = "awsboot"
    }
  
}
