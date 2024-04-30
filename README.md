# CI/CD

## Credentials

- Create an ssh key in `~/.ssh/id_rsa.pub`

## Requirements

- Login in Azure via CLI `az login`

## Init Azure Storage for Terraform state

- [Azure doc]("https://learn.microsoft.com/en-us/azure/developer/terraform/store-state-in-azure-storage?tabs=azure-cli")
```
#!/bin/bash

RESOURCE_GROUP_NAME=rg-m1a-tfstate
STORAGE_ACCOUNT_NAME=m1atfstate$RANDOM
CONTAINER_NAME=tfstate

# Create resource group
az group create --name $RESOURCE_GROUP_NAME --location francecentral

# Create storage account
az storage account create --resource-group $RESOURCE_GROUP_NAME --name $STORAGE_ACCOUNT_NAME --sku Standard_LRS --encryption-services blob

# Create blob container
az storage container create --name $CONTAINER_NAME --account-name $STORAGE_ACCOUNT_NAME
```

```
ACCOUNT_KEY=$(az storage account keys list --resource-group $RESOURCE_GROUP_NAME --account-name $STORAGE_ACCOUNT_NAME --query '[0].value' -o tsv)
export ARM_ACCESS_KEY=$ACCOUNT_KEY
```

## Terraform

- `cd ./terraform`
- `terraform init`
- `terraform plan`
- `terraform apply` > `yes`

## Connect to VM

- `ssh adminuser@{{public_ip_address}}`

## Cleanup after testing

- In `terraform` directory : `terraform destroy`
- In [Azure Portal]("https://portal.azure.com") destroy the Resource Group created in the script `rg-m1a-tfstate`