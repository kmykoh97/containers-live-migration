# Manager

Initialize cloud environment using Terraform v0.11. New version has newer api which might be incompatible with current configuration.

## Terraform

Terraform is an open-source infrastructure as code software tool that provides a consistent CLI workflow to manage hundreds of cloud services. Terraform codifies cloud APIs into declarative configuration files. It enables us to write config files for different cloud providers in declarative format.

## Cloud Providers' Credentials

### AWS

refer [here](https://docs.aws.amazon.com/ses/latest/DeveloperGuide/create-shared-credentials-file.html)

After authentication tokens are set up, the following policies are needed for the user's security group:

- AmazonEC2FullAccess
- AmazonVPCFullAccess

### GCP

Refer [here](https://www.terraform.io/docs/providers/google/index.html)

- Create a service account with biling
- Create credentials and download JSON. Refer [here](https://console.cloud.google.com/apis/credentials/serviceaccountkey)
- Set path in `gcp_credentials_path` below


### vm configs

There are several configuration files for terraform to recognize init workflow. If there is any other provisioning variables, replace the required content. In example:

- region: change region for vm deployment
- ami: existing value is ami-0dad20bd1b9c8c004, Ubuntu 18.04. Change similar configurations for gcp.tf or aws.tf respectively.

## SSH

```sh
# generate SSH keys(private & public key)
ssh-keygen -t rsa -b 4096 -C "kmykoh97@gmail.com"
```

Create `terraform.tfvars` with the following configs:

```sh
touch terraform.tfvars
vim terraform.tfvars

# key_name
# public_key_path
# private_key_path
# gcp_project_id
# gcp_credentials_path
```

Then, set up SSH agent:

```sh
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa
```

## Provisioning

Start Terraform.

```sh
# initialize
terraform init

# run config files
terraform apply
terraform output ansible_inventory > hosts # this hosts file will act as input configuration file for latter Ansible configurations

# terminate & clean-up resources after completion
terraform destroy 
```