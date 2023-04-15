

# resource "aws_key_pair" "dw-key" {
#   key_name   = var.KEY_PAIR_NAME
#   public_key = file("${path.module}/${var.PUBLIC_KEY}")
# }


resource "aws_security_group" "allow_ssh" {
  name        = "dw-sg"
  description = "Allow ssh inbound traffic"

  ingress {
    description      = "allow ssh access to ec2 instance"
    from_port        = 0
    to_port          = 0
    protocol         = -1
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_ssh"
  }
}



resource "aws_instance" "dw-instance" {
  ami             = var.AMIS[var.REGION]
  instance_type   = "t2.micro"
  key_name        = var.PUBLIC_KEY
  security_groups = [aws_security_group.allow_ssh.name]

  tags = {
    Name = "digiwallet instance"
    User = "saviganga"
  }
}

