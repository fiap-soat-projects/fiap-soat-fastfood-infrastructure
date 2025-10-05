data "terraform_remote_state" "infrastructure" {
  backend = "azurerm"
  config = {
    resource_group_name  = "rg-terraform-dev"
    storage_account_name = "safiapsoatterraformdev"
    container_name       = "tfstate"
    key                  = "infrastructure/terraform.tfstate"
  }
}

data "kubernetes_service" "fastfood_service" {
  metadata {
    name      = "fastfood-api"
    namespace = "fiap"
  }
}
