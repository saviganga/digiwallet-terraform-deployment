

terraform {
  source = "../../terraform/"
}

inputs = {
  KEY_PAIR_NAME = "dww-key"
  PUBLIC_KEY    = "dww-key.pub"
  REGION = "us-east-1"
  PRIVATE_KEY = "dww-key"
  INSTALL_K8S_UBUNTU = "bash_scripts/install-kubectl-ubuntu.sh"
  K8S_APP = "/Users/saviganga/Documents/working-boy/devOps/terraform/dw/start_cluster.sh"
}
