resource "azurerm_api_management_api" "fastfood_backend" {
  name                  = var.backend_name
  display_name          = var.backend_name
  resource_group_name   = var.apim_rg_name
  api_management_name   = var.apim_name
  service_url           = "http://${var.backend_service_ip}:80"
  revision              = "1"
  path                  = var.backend_path
  protocols             = ["https"]
  api_type              = "http"
  subscription_required = false
}

resource "azurerm_api_management_api_operation" "fastfood_api_operations" {
  for_each = local.fastfood_api_operations

  operation_id        = "wildcard-${each.key}"
  api_name            = azurerm_api_management_api.fastfood_backend.name
  api_management_name = var.apim_name
  resource_group_name = var.apim_rg_name
  display_name        = each.value.display_name
  method              = each.value.method
  url_template        = "/*"
}

resource "azurerm_api_management_api_policy" "fastfood_backend_wide_policy" {
  api_name            = azurerm_api_management_api.fastfood_backend.name
  api_management_name = var.apim_name
  resource_group_name = var.apim_rg_name

  xml_content = <<XML
    <policies>
      <inbound>
        <base />
        <validate-jwt header-name="Authorization" failed-validation-httpcode="401" failed-validation-error-message="Invalid or expired token.">          
          <openid-config url="${var.function_app_url}/api/.well-known/openid-configuration" />          
          <audiences>
            <audience>api://fastfood-api</audience>
          </audiences>          
          </validate-jwt>        
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
