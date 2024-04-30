# CI/CD

## Requirements

- Login in Azure via CLI `az login`
- Create [OIDC for Azure](https://learn.microsoft.com/en-us/azure/developer/github/connect-from-azure?tabs=azure-cli%2Clinux)
- Add following secrets to Terraform Cloud variables (avalaible from Azure Service Principle) : 
    - ARM_CLIENT_ID 
    - ARM_CLIENT_SECRET 
    - ARM_SUBSCRIPTION_ID 
    - ARM_TENANT_ID 

## Terraform

- `cd ./terraform`
- `terraform init`
- `terraform plan`
- `terraform apply` > `yes`

## Connect to VM

- `ssh adminuser@{{public_ip_address}}`

## Cleanup after testing

- In `terraform` directory : `terraform destroy`