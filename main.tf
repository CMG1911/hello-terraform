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

  provisioner "local-exec" {
    working_dir = "/home/sinensia/hello-terraform/ansible"
    command = "ansible-playbook -i aws_ec2.yml ec2.yml"
  }
}
