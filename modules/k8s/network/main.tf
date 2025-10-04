resource "azurerm_virtual_network" "vnet" {
  name                = "${var.aks_cluster_name}-vnet"
  location            = var.aks_location
  resource_group_name = var.aks_resource_group_name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "subnet" {
  name                 = "${var.aks_cluster_name}-subnet"
  resource_group_name  = var.aks_resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_public_ip" "aks_inbound_ip" {
  name                = "${var.aks_cluster_name}-service-ip"
  location            = var.aks_location
  resource_group_name = var.aks_resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_public_ip" "aks_outbound_ip" {
  name                = "${var.aks_cluster_name}-nat-ip"
  location            = var.aks_location
  resource_group_name = var.aks_resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_nat_gateway" "nat_gateway" {
  name                    = "${var.aks_cluster_name}-nat-gateway"
  location                = var.aks_location
  resource_group_name     = var.aks_resource_group_name
  sku_name                = "Standard"
  idle_timeout_in_minutes = 4
}

resource "azurerm_nat_gateway_public_ip_association" "ip_association" {
  nat_gateway_id       = azurerm_nat_gateway.nat_gateway.id
  public_ip_address_id = azurerm_public_ip.aks_outbound_ip.id
}

resource "azurerm_subnet_nat_gateway_association" "nat_association" {
  subnet_id      = azurerm_subnet.subnet.id
  nat_gateway_id = azurerm_nat_gateway.nat_gateway.id
}
