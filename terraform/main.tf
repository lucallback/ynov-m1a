terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "=3.0.1"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "random_pet" "rg-pet" {
}

resource "azurerm_resource_group" "rgtest" {
  name     = "rg-${random_pet.rg-pet.id}-001"
  location = "France Central"
  tags     = {env = "test", team = "developers"}
}