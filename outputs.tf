output "resource_group_name" {
  description = "Name of the resource group"
  value       = azurerm_resource_group.acthub.name
}

output "resource_group_location" {
  description = "Location of the resource group"
  value       = azurerm_resource_group.acthub.location
}

output "app_service_plan_id" {
  description = "ID of the App Service Plan"
  value       = azurerm_service_plan.acthub.id
}

output "app_service_plan_name" {
  description = "Name of the App Service Plan"
  value       = azurerm_service_plan.acthub.name
}

output "postgresql_server_fqdn" {
  description = "Fully Qualified Domain Name of the PostgreSQL server"
  value       = azurerm_postgresql_flexible_server.acthub.fqdn
}