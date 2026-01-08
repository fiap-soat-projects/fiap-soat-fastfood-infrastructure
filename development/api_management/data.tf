data "terraform_remote_state" "infrastructure" {
  backend = "azurerm"
  config = {
    resource_group_name  = "rg-terraform-dev"
    storage_account_name = "safiapsoatterraformdev"
    container_name       = "tfstate"
    key                  = "infrastructure/terraform.tfstate"
  }
}

data "terraform_remote_state" "function" {
  backend = "azurerm"
  config = {
    resource_group_name  = "rg-terraform-dev"
    storage_account_name = "safiapsoatterraformdev"
    container_name       = "tfstate"
    key                  = "function/terraform.tfstate"
  }
}

data "kubernetes_service" "fastfood_order_service" {
  metadata {
    name      = "fastfood-order-api"
    namespace = "fiap"
  }
}

data "kubernetes_service" "fastfood_payment_service" {
  metadata {
    name      = "fastfood-payment-api"
    namespace = "fiap"
  }
}

data "kubernetes_service" "fastfood_customer_service" {
  metadata {
    name      = "fastfood-customer-api"
    namespace = "fiap"
  }
}

data "azurerm_function_app_host_keys" "function_keys" {
  name                = data.terraform_remote_state.function.outputs.name
  resource_group_name = data.terraform_remote_state.function.outputs.rg
}
