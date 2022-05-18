terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  # secret_key = "xxxxxx"
  # access_key = "xxxxxx"
}

resource "aws_instance" "tf-docker-ec2" {
  ami = "ami-08e4e35cccc6189f4"
  instance_type = "t2.micro"
  key_name = "NorthVirginia"
  security_groups = ["tf-docker-sec-gr-203"]
  tags = {
    Name = "Web Server of Bookstore"
  }
  user_data = <<-EOF
          #! /bin/bash
          yum update -y
          amazon-linux-extras install docker -y
          systemctl start docker
          systemctl enable docker
          usermod -a -G docker ec2-user
          curl -L "https://github.com/docker/compose/releases/download/1.26.2/docker-compose-$(uname -s)-$(uname -m)" \
          -o /usr/local/bin/docker-compose
          chmod +x /usr/local/bin/docker-compose
          yum install git -y
          git clone https://github.com/joshuatallman/bookstore-project.git
          cd /home/ec2-user/bookstore-project
          docker build -t joshuatallman/bookstoreproject:latest .
          docker-compose up -d
          EOF

}


resource "aws_security_group" "tf-docker-sec-gr-203" {
  name = "tf-docker-sec-gr-203"
  tags = {
    Name = "tf-docker-sec-gr-203"
  }

  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 80
    protocol = "tcp"
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

}

output "website" {
  value = "http://${aws_instance.tf-docker-ec2.public_dns}"

}
