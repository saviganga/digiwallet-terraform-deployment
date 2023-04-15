

resource "aws_key_pair" "dw-key" {
  key_name   = var.KEY_PAIR_NAME
  public_key = "${file("${path.module}/${var.PUBLIC_KEY}")}"
}



# resource "aws_instance" "dw-instance" {
#     ami           = var.AMIS[var.REGION]
#     instance_type = "t2.micro"
#     key_name = var.KEY_NAME
#     security_groups = [var.SECURITY_GROUPS[var.REGION]]

#     tags = {
#         Name = "digiwallet instance"
#         User = "saviganga"
#     }
# }

