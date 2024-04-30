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

variable "ssh_pub_key" {
  type = string
  default = ""
}

provider "azurerm" {
  features {}
}

resource "random_pet" "rg-pet" {
}

resource "random_pet" "vm-pet" {
}

resource "azurerm_resource_group" "rgtest" {
  name     = "rg-${random_pet.rg-pet.id}-001"
  location = "France Central"
  tags     = { env = "test", team = "developers" }
}

resource "azurerm_virtual_network" "vm_network" {
  name                = "vm-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rgtest.location
  resource_group_name = azurerm_resource_group.rgtest.name
}

resource "azurerm_subnet" "vm_subnet" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.rgtest.name
  virtual_network_name = azurerm_virtual_network.vm_network.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_public_ip" "vm-pip" {
  name                    = "test-pip"
  location                = azurerm_resource_group.rgtest.location
  resource_group_name     = azurerm_resource_group.rgtest.name
  allocation_method       = "Dynamic"
  idle_timeout_in_minutes = 30
}

resource "azurerm_network_interface" "vm-nic" {
  name                = "internal-nic"
  location            = azurerm_resource_group.rgtest.location
  resource_group_name = azurerm_resource_group.rgtest.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.vm_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vm-pip.id
  }
}

resource "azurerm_linux_virtual_machine" "vm-test" {
  name                = "vm-${random_pet.vm-pet.id}-001"
  resource_group_name = azurerm_resource_group.rgtest.name
  location            = azurerm_resource_group.rgtest.location
  size                = "Standard_B1s"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.vm-nic.id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = var.ssh_pub_key
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}

output "public_ip_address" {
  value = azurerm_public_ip.vm-pip.ip_address
}