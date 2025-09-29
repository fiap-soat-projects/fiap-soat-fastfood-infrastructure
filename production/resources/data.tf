data "terraform_remote_state" "infrastructure" {
  backend = "azurerm"
  config = {
    resource_group_name  = "rg-terraform-prod"
    storage_account_name = "safiapsoatterraformprod"
    container_name       = "tfstate"
    key                  = "infrastructure/terraform.tfstate"
  }
}
