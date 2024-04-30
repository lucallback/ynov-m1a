# CI/CD

## Credentials

- Create an ssh key in `~/.ssh/id_rsa.pub`

## Terraform

- `cd ./terraform`
- `terraform init`
- `az login`
- `terraform plan`
- `terraform apply` > `yes`

## Connect to VM

- `ssh adminuser@{{public_ip_address}}`