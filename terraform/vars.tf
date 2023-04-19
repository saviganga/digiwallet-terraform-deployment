variable "REGION" {
  default = "us-east-1"
}

variable "AMIS" {
  type = map(any)
  default = {
    us-east-1 = "ami-007855ac798b5175e"
  }
}

variable "KEY_NAME" {
  default = "dww-key"
}

variable "PUBLIC_KEY" {
  type    = string
  default = "dww-key.pub"
}

variable "KEY_PAIR_NAME" {
  type    = string
  default = "dww-key"
}

variable "PRIVATE_KEY" {
  type    = string
  default = "dww-key"

}

variable "USER" {
  default = "ec2-user"
}

variable "INSTALL_ANSIBLE_UBUNTU" {
  default = "bash_scripts/install-ansible.sh"
}

variable "INSTALL_DOCKER_UBUNTU" {
  default = "bash_scripts/install-docker-ubuntu.sh"
}

variable "INSTALL_K8S_UBUNTU" {
  default = "bash_scripts/install-kubectl-ubuntu.sh"
}

variable "K8S_APP" {
  default = "/Users/saviganga/Documents/working-boy/devOps/terraform/dw/start_cluster.sh"
}


