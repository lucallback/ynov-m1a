# CI/CD

## Credentials

- Create an ssh key in `~/.ssh/id_rsa.pub`

## Requirements

- Login in Azure via CLI `az login`

## Terraform

- `cd ./terraform`
- `terraform init`
- `terraform plan`
- `terraform apply` > `yes`

## Connect to VM

- `ssh adminuser@{{public_ip_address}}`

## Cleanup after testing

- In `terraform` directory : `terraform destroy`