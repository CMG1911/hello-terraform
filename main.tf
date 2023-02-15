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

  user_data = <<EOF
        #!/bin/sh
        sudo yum update -y
        sudo yum install -y httpd.x86_64
        sudo systemctl start httpd.service
        sudo systemctl enable httpd.service
   
EOF  
}
