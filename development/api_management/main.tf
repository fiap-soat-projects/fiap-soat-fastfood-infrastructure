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

resource "azurerm_api_management_api_policy" "azfunc_wide_policy" {
  api_name            = azurerm_api_management_api.auth_azfunc.name
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = azurerm_resource_group.apim_rg.name

  xml_content = <<XML
    <policies>
      <inbound>
        <base />        
        <set-header name="x-functions-key" exists-action="override">
            <value>{{key-${data.terraform_remote_state.function.outputs.name}}}</value>
        </set-header>
      </inbound> 
      <backend>
          <base />
      </backend>
      <outbound>
          <base />
      </outbound>
      <on-error>
          <base />
      </on-error>
    </policies>
  XML
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

module "api_management_backend_fastfood_order" {
  source = "../../modules/api_management_backend"

  apim_name          = local.apim_name
  apim_rg_name       = local.apim_rg_name
  backend_name       = "fastfood-order-backend"
  backend_path       = "fastfood-order"
  backend_service_ip = local.fastfood_order_service_ip
  apim_gateway_url   = azurerm_api_management.apim.gateway_url
}

module "api_management_backend_fastfood_payment" {
  source = "../../modules/api_management_backend"

  apim_name          = local.apim_name
  apim_rg_name       = local.apim_rg_name
  backend_name       = "fastfood-payment-backend"
  backend_path       = "fastfood-payment"
  backend_service_ip = local.fastfood_payment_service_ip
  apim_gateway_url   = azurerm_api_management.apim.gateway_url
}

module "api_management_backend_fastfood_customer" {
  source = "../../modules/api_management_backend"

  apim_name          = local.apim_name
  apim_rg_name       = local.apim_rg_name
  backend_name       = "fastfood-customer-backend"
  backend_path       = "fastfood-customer"
  backend_service_ip = local.fastfood_customer_service_ip
  apim_gateway_url   = azurerm_api_management.apim.gateway_url
}
