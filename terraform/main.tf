# 1. Specify the version of the AzureRM Provider to use
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "=3.0.1"
    }
  }
}

# 2. Configure the AzureRM Provider
provider "azurerm" {
  features {}
}

resource "random_pet" "rg-pet" {
}

# 3. Create a resource group
resource "azurerm_resource_group" "rgtest" {
  name     = "rg-${random_pet.rg-pet.id}-001"
  location = "France Central"
  tags     = {env = "test"}
}

