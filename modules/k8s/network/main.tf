resource "azurerm_virtual_network" "vnet" {
  name                = "${var.cluster_name}-vnet"
  location            = var.cluster_location
  resource_group_name = var.cluster_rg
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "subnet" {
  name                 = "${var.cluster_name}-subnet"
  resource_group_name  = var.cluster_rg
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_public_ip" "aks_outbound_ip" {
  name                = "${var.cluster_name}-nat-ip"
  location            = var.cluster_location
  resource_group_name = var.cluster_rg
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_nat_gateway" "nat_gateway" {
  name                    = "${var.cluster_name}-nat-gateway"
  location                = var.cluster_location
  resource_group_name     = var.cluster_rg
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
