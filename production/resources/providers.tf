terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.38.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "rg-terraform-prod"
    storage_account_name = "safiapsoatterraformprod"
    container_name       = "tfstate"
    key                  = "infrastructure/resources/terraform.tfstate"
  }
}

provider "kubernetes" {
  host                   = data.terraform_remote_state.infrastructure.outputs.host
  cluster_ca_certificate = base64decode(data.terraform_remote_state.infrastructure.outputs.ca_certificate)

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "kubelogin"
    args = [
      "get-token",
      "--tenant-id", data.terraform_remote_state.infrastructure.outputs.tenant_id,
      "--server-id", data.terraform_remote_state.infrastructure.outputs.aks_aad_server_id,
      "--login", "azurecli"
    ]
  }
}
