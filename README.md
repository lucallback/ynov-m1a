# CI/CD

## Credentials

- Create an ssh key in `~/.ssh/id_rsa.pub`

## Init Azure Storage for Terraform state

- [Azure doc]("https://learn.microsoft.com/en-us/azure/developer/terraform/store-state-in-azure-storage?tabs=azure-cli")
- `chmod +x ./initstorage.sh`
- `./initsotrage.sh`

## Terraform

- `cd ./terraform`
- `terraform init`
- `az login`
- `terraform plan`
- `terraform apply` > `yes`

## Connect to VM

- `ssh adminuser@{{public_ip_address}}`

## Cleanup after testing

- In `terraform` directory : `terraform destroy`
- In [Azure Portal]("https://portal.azure.com") destroy the Resource Group created in the script `rg-m1a-tfstate`