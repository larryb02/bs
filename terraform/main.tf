provider "aws" {
  region = "us-east-1"
}

data "aws_ami" "fedora" {
  most_recent = true

  filter {
    name = "name"
    values = [" (SupportedImages) - Fedora-Cloud-Base-AmazonEC2.x86_64-42-1.1 - *"]
  }

  owners = ["679593333241"]
}

resource "aws_instance" "app_server" {
  ami           = data.aws_ami.fedora.id
  instance_type = "t2.micro"

  tags = {
    Name = "devbs"
  }
}
