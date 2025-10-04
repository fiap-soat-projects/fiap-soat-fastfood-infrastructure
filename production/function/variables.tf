variable "subscription_id" {
  description = "The subscription ID where resources will be created"
  type        = string
}

variable "tenantid_id" {
  description = "The Azure AD tenant ID for the AKS cluster"
  type        = string
}

variable "region" {
  description = "The Azure region where resources will be created"
  type        = string
  default     = "eastus"
}
