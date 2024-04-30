# CI/CD

## Credentials

- Create an ssh key in `~/.ssh/id_rsa.pub`

## Requirements

- Login in Azure via CLI `az login`
- Create [OIDC for Azure](https://learn.microsoft.com/en-us/azure/developer/github/connect-from-azure?tabs=azure-cli%2Clinux)

## Terraform

- `cd ./terraform`
- `terraform init`
- `terraform plan`
- `terraform apply` > `yes`

## Connect to VM

- `ssh adminuser@{{public_ip_address}}`

## Cleanup after testing

- In `terraform` directory : `terraform destroy`