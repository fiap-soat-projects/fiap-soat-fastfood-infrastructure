variable "subscription_id" {
  description = "The subscription ID where resources will be created"
  type        = string
}

variable "region" {
  description = "The Azure region where resources will be created"
  type        = string
  default     = "eastus"
}