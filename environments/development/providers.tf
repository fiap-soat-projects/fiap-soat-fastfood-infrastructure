terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.45.1"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.38.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "rg-terraform-dev"
    storage_account_name = "safiapsoatterraformdev"
    container_name       = "tfstate"
    key                  = "infrastructure/terraform.tfstate"
  }
}

provider "azurerm" {
  resource_provider_registrations = "none"
  subscription_id                 = var.subscription_id
  features {}
}

provider "kubernetes" {
  host                   = module.cluster.host
  cluster_ca_certificate = base64decode(module.cluster.ca_certificate)

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "kubelogin"
    args = [
      "get-token",
      "--tenant-id", var.tenantid_id,
      "--server-id", var.aks_aad_server_id,
      "--login", "azurecli"
    ]
  }
}
