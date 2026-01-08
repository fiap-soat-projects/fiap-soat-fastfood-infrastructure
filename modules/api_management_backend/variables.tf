variable "apim_name" {
  description = "The name of the API Management instance."
  type        = string
}

variable "apim_rg_name" {
  description = "The name of the Resource Group where the API Management instance is located."
  type        = string
}

variable "backend_name" {
  description = "The name of the backend API."
  type        = string
}

variable "backend_path" {
  description = "The path of the backend API."
  type        = string
}

variable "backend_service_ip" {
  description = "The IP address of the backend service."
  type        = string
}

variable "apim_gateway_url" {
  description = "The gateway URL of the API Management instance."
  type        = string
}
