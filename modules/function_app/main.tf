resource "azurerm_storage_account" "azfunc_sa" {
  name                     = var.azfunc_sa_name
  resource_group_name      = var.azfunc_rg_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "azfunc_sc" {
  name                  = "function"
  storage_account_id    = azurerm_storage_account.azfunc_sa.id
  container_access_type = "private"
}

resource "azurerm_service_plan" "azfunc_asp" {
  name                = var.azfunc_asp_name
  resource_group_name = var.azfunc_rg_name
  location            = var.location
  sku_name            = "FC1"
  os_type             = "Linux"
}

resource "azurerm_function_app_flex_consumption" "azfunc" {
  name                = var.azfunc_name
  resource_group_name = var.azfunc_rg_name
  location            = var.location
  service_plan_id     = azurerm_service_plan.azfunc_asp.id

  storage_container_type      = "blobContainer"
  storage_container_endpoint  = "${azurerm_storage_account.azfunc_sa.primary_blob_endpoint}${azurerm_storage_container.azfunc_sc.name}"
  storage_authentication_type = "StorageAccountConnectionString"
  storage_access_key          = azurerm_storage_account.azfunc_sa.primary_access_key
  runtime_name                = "dotnet-isolated"
  runtime_version             = "8.0"
  maximum_instance_count      = 40
  instance_memory_in_mb       = 512

  site_config {}
}
