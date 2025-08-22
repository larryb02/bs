provider "aws" {
  region = "us-east-1"
}

data "aws_ami" "fedora" {
  most_recent = true

  filter {
    name   = "name"
    values = [" (SupportedImages) - Fedora-Cloud-Base-AmazonEC2.x86_64-42-1.1 - *"]
  }

  owners = ["679593333241"]
}

data "aws_key_pair" "app_public_key" {
  key_name = "app_key"
}

data "aws_security_group" "apps" {
  name = "Fedora 42 (Fedora Cloud 42) - Support by SupportedImages-20250804-AutogenByAWSMP--1"
}

resource "aws_instance" "app_server" {
  ami           = data.aws_ami.fedora.id
  instance_type = "t2.micro"
  key_name      = data.aws_key_pair.app_public_key.key_name
  vpc_security_group_ids = [ data.aws_security_group.apps.id ]

  tags = {
    Name = "devbs"
  }
}

output "vm_public_ip" {
  value = aws_instance.app_server.public_ip
}
