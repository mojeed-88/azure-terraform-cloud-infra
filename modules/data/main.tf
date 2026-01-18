resource "random_password" "sql_password" {
  length  = 16
  special = true
}

resource "azurerm_key_vault" "kv" {
  name                        = "${var.project_name}-${var.environment}-kv"
  location                    = var.location
  resource_group_name         = var.resource_group_name
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  sku_name                    = "standard"
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false
}

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault_secret" "sql_password" {
  name         = "sql-admin-password"
  value        = random_password.sql_password.result
  key_vault_id = azurerm_key_vault.kv.id
}

resource "azurerm_mssql_server" "sql" {
  name                         = "${var.project_name}-${var.environment}-sql"
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = var.sql_admin_username
  administrator_login_password = random_password.sql_password.result
}

resource "azurerm_mssql_database" "db" {
  name      = "${var.project_name}-${var.environment}-db"
  server_id = azurerm_mssql_server.sql.id
  sku_name  = "Basic"
}
