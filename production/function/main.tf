resource "azurerm_resource_group" "azfunc_rg" {
  name     = local.azfunc_rg_name
  location = var.region
}

module "azfunc" {
  source           = "../../modules/function_app"
  azfunc_rg_name   = azurerm_resource_group.azfunc_rg.name
  location         = azurerm_resource_group.azfunc_rg.location
  azfunc_sa_name   = local.azfunc_sa_name
  azfunc_asp_name  = local.azfunc_asp_name
  azfunc_appi_name = local.azfunc_appi_name
  azfunc_name      = local.azfunc_name

  depends_on = [azurerm_resource_group.azfunc_rg]
}

resource "azurerm_key_vault" "auth_kv" {
  name                       = local.kv_name
  location                   = azurerm_resource_group.azfunc_rg.location
  resource_group_name        = azurerm_resource_group.azfunc_rg.name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "standard"
  soft_delete_retention_days = 7

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get", "List", "Create", "Delete", "Recover", "Update"
    ]
    secret_permissions = [
      "Get", "List", "Set", "Delete", "Recover"
    ]
  }
}
