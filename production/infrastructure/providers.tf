terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.45.1"
    }
  }

  backend "azurerm" {
    resource_group_name  = "rg-terraform-prod"
    storage_account_name = "safiapsoatterraformprod"
    container_name       = "tfstate"
    key                  = "infrastructure/terraform.tfstate"
  }
}

provider "azurerm" {
  resource_provider_registrations = "none"
  subscription_id                 = var.subscription_id
  features {}
}
