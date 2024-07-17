provider aws {
    region = "us-west-2"
}

resource "aws_key_pair" "Bastion-key" {
  key_name   = "Bastion"
  public_key = file("~/.ssh/id_rsa.pub")
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  #availability_zone = element(["us-west-2a", "us-west-2b", "us-west-2c"], count.index)
  subnet_id = "subnet-09376ba2702e9acb6"
  count = 3
  key_name = aws_key_pair.Bastion-key.key_name
  vpc_security_group_ids = [aws_security_group.web-sg.id]
  user_data = file("apache.sh")

  tags = {
    Name = "HelloWorld"
  }
}

