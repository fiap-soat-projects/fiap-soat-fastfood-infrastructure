variable "subscription_id" {
  description = "The subscription ID where resources will be created"
  type        = string
}

variable "tenantid_id" {
  description = "The Azure AD tenant ID for the AKS cluster"
  type        = string
}

variable "location" {
  description = "The Azure region where resources will be created"
  type        = string
  default     = "eastus"
}

variable "aks_aad_server_id" {
  description = "The Application ID of the AKS AAD Server Service Principal"
  type        = string
  default     = "6dae42f8-4368-4678-94ff-3960e28e3630"
}
