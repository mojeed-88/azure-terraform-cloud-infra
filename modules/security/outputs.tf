output "web_nsg_id" {
  value = azurerm_network_security_group.web_nsg.id
}

output "app_nsg_id" {
  value = azurerm_network_security_group.app_nsg.id
}

output "db_nsg_id" {
  value = azurerm_network_security_group.db_nsg.id
}
