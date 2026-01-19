output "sql_server_name" {
  value = azurerm_mssql_server.sql.name
}

output "key_vault_name" {
  value = azurerm_key_vault.kv.name
}

output "sql_server_id" {
  value = azurerm_mssql_server.sql.id
}
