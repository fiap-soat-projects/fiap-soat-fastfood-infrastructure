resource "azurerm_resource_group" "rg" {
  name     = local.aks_rg_name
  location = var.region
}

module "network" {
  source                  = "../../modules/k8s/network"
  aks_resource_group_name = local.aks_rg_name
  aks_cluster_name        = local.aks_cluster_name
  aks_location            = var.region

  depends_on = [azurerm_resource_group.rg]
}

module "cluster" {
  source                  = "../../modules/k8s/cluster"
  subscription_id         = var.subscription_id
  tenantid_id             = var.tenantid_id
  aks_resource_group_name = local.aks_rg_name
  aks_cluster_name        = local.aks_cluster_name
  location                = var.region
  vnet_subnet_id          = module.network.subnet_id
  aks_rg_network_id       = azurerm_resource_group.rg.id

  depends_on = [module.network]
}
