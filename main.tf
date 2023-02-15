terraform {

  required_providers {
    aws = {
      source = "hashicorp/aws"

      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {

  region = "eu-west-1"

}

resource "aws_instance" "app_server" {

  ami                    = "ami-0b752bf1df193a6c4"
  instance_type          = "t2.micro"
  key_name               = "clave-lucatic2"
  subnet_id              = "subnet-04acd65b96246a2df"
  vpc_security_group_ids = ["sg-01a5d2ec6fc03cc92"]

  tags = {

    Name = var.instance_name
    APP  = "vue2048"
  }

  connection {
    host        = self.public_ip
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("/home/sinensia/.ssh/clave-lucatic2.pem")
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum install -y httpd.x86_64",
      "sudo systemctl start httpd.service",
      "sudo systemctl enable httpd.service",
      "sudo chown -R ec2-user /var/www/html",
    ]
  }

  provisioner "file" {
    source      = "../hello-2048/public_html/"
    destination = "/var/www/html"
  }
}
