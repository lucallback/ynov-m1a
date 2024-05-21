terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.1"
    }
  }
  backend "remote" {
    organization = "CICDM1A"
    workspaces {
      name = "ynov-m1a-ws"
    }
  }
}

provider "azurerm" {
  features {}
}