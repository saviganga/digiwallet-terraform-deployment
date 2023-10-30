provider "aws" {
  region = var.REGION
}

# remote_state {
#   backend = "s3"
#   config = {
#     bucket         = "my-terraform-state-bucket"
#     key            = "${path_relative_to_include()}/terraform.tfstate"
#     region         = "us-west-2"
#   }
# }