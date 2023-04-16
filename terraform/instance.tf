
# provision key 
resource "aws_key_pair" "dw-key" {
  key_name   = var.KEY_PAIR_NAME
  public_key = file("${path.module}/${var.PUBLIC_KEY}")
}

# provision security group
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


# provision ec2 instance
resource "aws_instance" "dw-instance" {
  ami             = var.AMIS[var.REGION]
  instance_type   = "t2.micro"
  key_name        = aws_key_pair.dw-key.key_name
  security_groups = [aws_security_group.allow_ssh.name]

  # create a connection to the ec2 instance to run provisioner commands
  connection {
    type        = "ssh"
    user        = "ubuntu"
    host        = self.public_ip
    private_key = file(var.PRIVATE_KEY)
  }

  ## provisioner to install ansible on the ec2 instance :
  provisioner "file" {
    source      = var.INSTALL_ANSIBLE_UBUNTU
    destination = "/tmp/install-ansible.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "sudo chmod u+x /tmp/install-ansible.sh",
      "/tmp/install-ansible.sh",
    ]
  }

  ## provisioner to install docker on the ec2 instance :
  provisioner "file" {
    source      = var.INSTALL_DOCKER_UBUNTU
    destination = "/tmp/install-docker-ubuntu.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "sudo chmod u+x /tmp/install-docker-ubuntu.sh",
      "/tmp/install-docker-ubuntu.sh",
    ]
  }

  ## provisioner to install k8s on the ec2 instance :
  provisioner "file" {
    source      = var.INSTALL_K8S_UBUNTU
    destination = "/tmp/install-k8s-ubuntu.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "sudo chmod u+x /tmp/install-k8s-ubuntu.sh",
      "/tmp/install-k8s-ubuntu.sh",
    ]
  }

  tags = {
    Name = "digiwallet instance"
    User = "saviganga"
  }
}

