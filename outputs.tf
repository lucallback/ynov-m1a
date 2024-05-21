output "public_ip_address" {
  value = azurerm_public_ip.vm-pip.ip_address
}

output "rg" {
  value = azurerm_resource_group.rgtest.name
}