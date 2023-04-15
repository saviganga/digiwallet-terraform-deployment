# digiwallet-terraform-deployment

- This project highlights infrastructure provisioning using Terraform
- After infrastructure provisioning, the infrasturcture OS is configured using Ansible
- The digiwallet microservice application is managed by a kubernetes cluster
- cloud provider is AWS

# STEPS

- TERRAFORM

1. grant terraform programmatic access to AWS by setting ACCESS_KEY and ACCESS_SECRET_KEY (setting up on awsCLI is best practice)

2. create 'vars.tf' file to store reusable variables across terraform workflow scripts

3. create 'provider.tf' file to define the cloud service used for the terraform workflow

4. create key pair (locally or directly on AWS) - used to access EC2 instance created

