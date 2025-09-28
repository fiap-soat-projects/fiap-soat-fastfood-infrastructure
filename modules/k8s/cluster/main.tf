resource "azurerm_resource_group" "rg" {
  name     = var.aks_rg_name
  location = var.location
}

# module "network" {
#   source           = "../network"
#   cluster_name     = var.aks_cluster_name
#   cluster_location = azurerm_resource_group.rg.location
#   cluster_rg       = azurerm_resource_group.rg.name
# }

resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_cluster_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = var.aks_cluster_name
  sku_tier            = "Free"

  default_node_pool {
    name            = "systempool"
    node_count      = 1
    vm_size         = "Standard_B2s"
    os_disk_size_gb = 30

    #vnet_subnet_id = module.network.subnet_id

    upgrade_settings {
      drain_timeout_in_minutes      = 0
      max_surge                     = "10%"
      node_soak_duration_in_minutes = 0
    }
  }

  # network_profile {
  #   network_plugin = "azure"
  #   outbound_type  = "userAssignedNATGateway"
  # }

  azure_active_directory_role_based_access_control {
    azure_rbac_enabled = true
    tenant_id          = var.tenantid_id
  }

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_role_assignment" "aks_cluster_admin" {
  scope                = azurerm_kubernetes_cluster.aks.id
  role_definition_name = "Azure Kubernetes Service RBAC Cluster Admin"
  principal_id         = data.azurerm_client_config.current.object_id
}
