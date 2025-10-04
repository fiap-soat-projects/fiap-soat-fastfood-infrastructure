variable "azfunc_rg_name" {
  description = "The name of the Resource Group in which to create the Function App"
  type        = string
}

variable "azfunc_sa_name" {
  description = "The name of the Storage Account to be created for the Function App"
  type        = string
}

variable "azfunc_asp_name" {
  description = "The name of the Service Plan to be created for the Function App"
  type        = string
}

variable "azfunc_appi_name" {
  description = "The name of the Application Insights instance to be created for the Function App"
  type        = string
}

variable "azfunc_name" {
  description = "The name of the Function App to be created"
  type        = string
}

variable "location" {
  description = "The Azure region in which to create the resources"
  type        = string
}
