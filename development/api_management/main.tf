resource "azurerm_resource_group" "apim_rg" {
  name     = local.apim_rg_name
  location = var.region
}

resource "azurerm_api_management" "apim" {
  name                = local.apim_name
  location            = azurerm_resource_group.apim_rg.location
  resource_group_name = azurerm_resource_group.apim_rg.name

  publisher_name  = "Fiap Soat Fastfood"
  publisher_email = "jefersondsgomes@gmail.com"

  sku_name = "Developer_1"
}

resource "azurerm_api_management_api" "auth_azfunc" {
  name                  = local.apim_auth_function_name
  display_name          = local.apim_auth_function_name
  resource_group_name   = azurerm_resource_group.apim_rg.name
  api_management_name   = azurerm_api_management.apim.name
  revision              = "1"
  path                  = ""
  protocols             = ["https"]
  api_type              = "http"
  service_url           = data.terraform_remote_state.function.outputs.url
  subscription_required = false
}

resource "azurerm_api_management_api_operation" "azfunc_auth_operations" {
  for_each = local.auth_function_operations

  operation_id        = each.key
  api_name            = azurerm_api_management_api.auth_azfunc.name
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = azurerm_resource_group.apim_rg.name
  display_name        = each.value.display_name
  method              = each.value.method
  url_template        = each.value.template
}

resource "azurerm_api_management_named_value" "azfunc_key_nv" {
  name                = "key-${data.terraform_remote_state.function.outputs.name}"
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = azurerm_api_management.apim.resource_group_name
  display_name        = "key-${data.terraform_remote_state.function.outputs.name}"
  value               = data.azurerm_function_app_host_keys.function_keys.default_function_key
  secret              = true
  tags                = ["function", "key"]
}

resource "azurerm_api_management_api" "fastfood_backend" {
  name                  = local.apim_fastfood_backend_name
  display_name          = local.apim_fastfood_backend_name
  resource_group_name   = azurerm_resource_group.apim_rg.name
  api_management_name   = azurerm_api_management.apim.name
  service_url           = "http://${local.fastfood_service_ip}:80"
  revision              = "1"
  path                  = "fastfood"
  protocols             = ["https"]
  api_type              = "http"
  subscription_required = false
}

resource "azurerm_api_management_api_operation" "fastfood_api_operations" {
  for_each = local.fastfood_api_operations

  operation_id        = "wildcard-${each.key}"
  api_name            = azurerm_api_management_api.fastfood_backend.name
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = azurerm_resource_group.apim_rg.name
  display_name        = each.value.display_name
  method              = each.value.method
  url_template        = "/*"
}
