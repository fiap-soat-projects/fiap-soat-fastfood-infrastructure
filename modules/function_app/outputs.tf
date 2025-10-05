output "id" {
  value = azurerm_function_app_flex_consumption.azfunc.id
}

output "azfunc_identity_principal_id" {
  value = azurerm_function_app_flex_consumption.azfunc.identity[0].principal_id
}

output "azfunc_name" {
  value = azurerm_function_app_flex_consumption.azfunc.name
}

output "azfunc_url" {
  description = "A URL de acesso padrão para o Azure Function App."
  value       = "https://${azurerm_function_app_flex_consumption.azfunc.default_hostname}"
}
