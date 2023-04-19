# digiwallet-terraform-deployment

- This project highlights infrastructure provisioning using Terraform
- After infrastructure provisioning, the infrasturcture OS is configured using Ansible
- The digiwallet microservice application is managed by a kubernetes cluster
- cloud provider is AWS


# PREREQUISITES
1. docker
2. minikube/docker-desktop
3. kubernetes enabled
4. basic knowledge of kubernetes
5. knowledge of django is a bonus
6. ansible
7. terraform
8. basic knowledge of aws ec2 is a bonus

# DIRECTORY EXPLANATION
1. terraform/
    - provider.tf: contains the cloud service provider to be provisioned by terraform
    - vars.tf: contains variables to be used across terraform deployment
    - instance.tf: contains terraform cloud resource provisioning script
    - bash_scripts/
        - install-kubectl-ubuntu.sh: helper script to install kubectl on remote host provisioned by terraform

2. ansible/
    - playbooks/
        - installsyspackages.yml: ansible playbook to update apt packages on the provisioned ec2 instance
        - installdocker.yml: ansible playbook to install docker and docker-compose on the provisioned ec2 instance

3. dw/
    - authService/
        - django microservice to handle user authentication
    
    - configService
        - django microservice to handle general configurations

    - walletApp
        - django microservice to handle wallet logic

    - deploy
        - k8s: folder containing configuration files for kubernetes deployment and management
            - secrets.yml: contains base64 encrypted secrets for k8s cluster
            - configmap.yml: contains environment variables for k8s cluster
            - ingress.yml: contains imgress routing rules. Maps domain names to internal services for acess from the internet.
            - db:
                - pv.yml: persistent volume configuration file - used to reserve a specified amount of storage
                - pvc.yml: persistent volume claim configuration file - used to utilize the reserved storage in persistent volume
                - deployment.yml: deployment configuration file for postgres database
                - service.yml: service configuration file for postgres deployment - used to access the pod (internally by other pods)
            - redis:
                - deployment.yml: deployment configuration file for redis
                - service.yml: service configuration file for redis deployment - used to access the pod (internally by other pods)
            - auth:
                - deployment.yml: deployment configuration file for django auth microservice
                - service.yml: service configuration file for django auth microservice deployment - used to access the pod (internally by other pods and externally from the internet- nodePort)
            - celery:
                - deployment.yml: deployment configuration file for celery worker
                - service.yml: service configuration file for celery worker deployment - used to access the pod (internally by other pods)
            - config:
                - deployment.yml: deployment configuration file for django config microservice
                - service.yml: service configuration file for django config microservice deployment - used to access the pod (internally by other pods and externally from the internet- nodePort)
            - wallet:
                - deployment.yml: deployment configuration file for django wallet microservice
                - service.yml: service configuration file for django wallet microservice deployment - used to access the pod (internally by other pods and externally from the internet- nodePort)

            - start_cluster.sh
                - bash script with commands to start the kubernetes cluster



# STEPS

- TERRAFORM

1. grant terraform programmatic access to AWS by setting ACCESS_KEY and ACCESS_SECRET_KEY (setting up on awsCLI is best practice)

2. create 'vars.tf' file to store reusable variables across terraform workflow scripts

3. create 'provider.tf' file to define the cloud service used for the terraform workflow

4. create key pair (locally or directly on AWS) - used to access EC2 instance created

5. create security group with access ingress and egress rules for the ec2 instance

6. create the ec2 instance

7. install OS dependencies for application (apt-updates, docker, kubectl) - using terraform/ansible provisioning
    - kubectl is proisioned via terraform 'file' and 'remote-exec' provisioners (remote-exec provisioner requires an ssh connection to the remote host)
    - apt-updates and docker are installed using ansible playbooks - the ansible playbooks are run using the 'remote-exec' and 'local-exec' provisioners after an ssh connection to the remote host has been established

8. provision the kubernetes application - with the established remote ssh connection, the kubernetes application is provisioned from the remote host using the 'local-exec' provisioner

