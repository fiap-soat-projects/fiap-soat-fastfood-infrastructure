variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}

variable "tenantid_id" {
  description = "Azure Active Directory Tenant ID"
  type        = string
}

variable "aks_rg_name" {
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
