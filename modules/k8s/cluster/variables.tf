variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}

variable "tenantid_id" {
  description = "Azure Active Directory Tenant ID"
  type        = string
}

variable "aks_resource_group_name" {
  description = "Name of the Resource Group for AKS"
  type        = string
}

variable "aks_cluster_name" {
  description = "Name of the AKS Cluster"
  type        = string
}

variable "location" {
  description = "Azure region for the resources"
  type        = string
}

variable "vnet_subnet_id" {
  description = "The ID of the subnet in the virtual network"
  type        = string
}

variable "aks_service_cidr" {
  description = "CIDR range for Kubernetes services. Must NOT overlap with VNet or Subnet ranges"
  type        = string
  default     = "192.168.0.0/16"
}

variable "aks_dns_service_ip" {
  description = "IP address within the Kubernetes service CIDR range for the DNS service"
  type        = string
  default     = "192.168.0.10"
}

variable "aks_rg_network_id" {
  description = "The ID of the Resource Group where the network resources are deployed"
  type        = string
}
