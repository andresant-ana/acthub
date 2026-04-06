resource "azurerm_resource_group" "acthub" {
  name     = "rg-acthub-${var.environment}"
  location = var.location
}

resource "azurerm_service_plan" "acthub" {
  name                = "plan-acthub-${var.environment}"
  location            = azurerm_resource_group.acthub.location
  resource_group_name = azurerm_resource_group.acthub.name
  os_type             = "Linux"
  sku_name            = "F1"
}

resource "azurerm_postgresql_flexible_server" "acthub" {
  name                   = "psql-acthub-${var.environment}"
  resource_group_name    = azurerm_resource_group.acthub.name
  location               = azurerm_resource_group.acthub.location
  version                = "16"
  administrator_login    = var.db_admin_user
  administrator_password = var.db_admin_password
  sku_name               = "B_Standard_B1ms"
  storage_mb             = 32768

  lifecycle {
    ignore_changes = [
      zone,
      high_availability
    ]
  }
}

resource "azurerm_postgresql_flexible_server_firewall_rule" "allow_azure_internal" {
  name             = "AllowAzureInternal"
  server_id        = azurerm_postgresql_flexible_server.acthub.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "acthub" {
  name                     = "kv-acthub-${var.environment}"
  resource_group_name      = azurerm_resource_group.acthub.name
  location                 = azurerm_resource_group.acthub.location
  tenant_id                = data.azurerm_client_config.current.tenant_id
  sku_name                 = "standard"
  purge_protection_enabled = false
}

resource "azurerm_key_vault_access_policy" "acthub" {
  key_vault_id = azurerm_key_vault.acthub.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  secret_permissions = [
    "Get", "List", "Set", "Delete",
    "Recover", "Backup", "Restore", "Purge"
  ]
}

resource "azurerm_key_vault_secret" "db_admin_password" {
  name         = "db-admin-password"
  value        = var.db_admin_password
  key_vault_id = azurerm_key_vault.acthub.id

  depends_on = [azurerm_key_vault_access_policy.acthub]
}