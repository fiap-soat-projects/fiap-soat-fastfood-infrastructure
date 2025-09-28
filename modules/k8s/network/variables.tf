variable "cluster_name" {
  description = "The name of the AKS cluster."
  type        = string
}

variable "cluster_rg" {
  description = "The name of the Resource Group for AKS."
  type        = string
}

variable "cluster_location" {
  description = "The Azure region where the AKS cluster will be deployed."
  type        = string
}
