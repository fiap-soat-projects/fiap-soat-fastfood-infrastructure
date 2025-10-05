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
  name                     = local.kv_name
  location                 = azurerm_resource_group.azfunc_rg.location
  resource_group_name      = azurerm_resource_group.azfunc_rg.name
  tenant_id                = data.azurerm_client_config.current.tenant_id
  sku_name                 = "standard"
  purge_protection_enabled = false

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions    = ["Get", "List", "Create", "Delete", "Recover", "Update", "GetRotationPolicy", "SetRotationPolicy"]
    secret_permissions = ["Get", "List", "Set", "Delete", "Recover"]
  }

  access_policy {
    tenant_id       = data.azurerm_client_config.current.tenant_id
    object_id       = module.azfunc.azfunc_identity_principal_id
    key_permissions = ["Get", "Sign", "Verify"]
  }

  depends_on = [module.azfunc]
}

resource "tls_private_key" "rsa_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "azurerm_key_vault_key" "auth_kv_rsa_key" {
  name         = local.kv_rsa_name
  key_vault_id = azurerm_key_vault.auth_kv.id
  key_type     = tls_private_key.rsa_key.algorithm
  key_size     = tls_private_key.rsa_key.rsa_bits
  key_opts = [
    "decrypt",
    "encrypt",
    "sign",
    "unwrapKey",
    "verify",
    "wrapKey",
  ]
  depends_on = [azurerm_key_vault.auth_kv]
}
