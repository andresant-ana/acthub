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