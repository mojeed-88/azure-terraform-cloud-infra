resource "azurerm_log_analytics_workspace" "law" {
  name                = "${var.project_name}-${var.environment}-law"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

# Web VM diagnostics
resource "azurerm_monitor_diagnostic_setting" "web_diag" {
  name                       = "web-vm-diag"
  target_resource_id         = var.web_vm_id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.law.id

  enabled_log { category = "VMProtectionAlerts" }

  metric { category = "AllMetrics" }
}

# App VM diagnostics
resource "azurerm_monitor_diagnostic_setting" "app_diag" {
  name                       = "app-vm-diag"
  target_resource_id         = var.app_vm_id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.law.id

  enabled_log { category = "VMProtectionAlerts" }

  metric { category = "AllMetrics" }
}

# SQL diagnostics
resource "azurerm_monitor_diagnostic_setting" "sql_diag" {
  name                       = "sql-diag"
  target_resource_id         = var.sql_server_id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.law.id

  enabled_log {
    category = "SQLSecurityAuditEvents"
  }

  metric { category = "AllMetrics" }
}

# High CPU alert (web)
resource "azurerm_monitor_metric_alert" "web_cpu" {
  name                = "${var.project_name}-${var.environment}-web-high-cpu"
  resource_group_name = var.resource_group_name
  scopes              = [var.web_vm_id]
  severity            = 2

  criteria {
    metric_namespace = "Microsoft.Compute/virtualMachines"
    metric_name      = "Percentage CPU"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 80
  }
}
