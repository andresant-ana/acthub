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
}

resource "azurerm_postgresql_flexible_server_firewall_rule" "allow_azure_internal" {
  name             = "AllowAzureInternal"
  server_id        = azurerm_postgresql_flexible_server.acthub.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}