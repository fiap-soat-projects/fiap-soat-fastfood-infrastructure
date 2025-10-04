variable "aks_cluster_name" {
  description = "The name of the AKS cluster."
  type        = string
}

variable "aks_resource_group_name" {
  description = "The name of the Resource Group for AKS."
  type        = string
}

variable "aks_location" {
  description = "The Azure region where the AKS cluster will be deployed."
  type        = string
}
