variable "REGION" {
    default = "us-east-1"
}

variable "AMIS" {
    type = map
    default = {
        us-east-1 = "ami-06e46074ae430fba6"
    }
}

variable "KEY_NAME" {
    default = "dw-key"
}

variable "SECURITY_GROUPS" {
    type = map
    default = {
        us-east-1 = "dw-sg"
    }
}

variable "PUBLIC_KEY" {
  type = string
  default  = "dw-key.pub"
}

variable "KEY_PAIR_NAME" {
  type = string
  default  = "dw-key"
}