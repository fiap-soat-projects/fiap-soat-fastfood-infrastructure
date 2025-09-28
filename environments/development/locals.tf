locals {
  backend_rg_name        = "rg-terraform-dev"
  backend_sa_name        = "safiapsoatterraformdev"
  backend_container_name = "tfstate"
}

locals {
  aks_rg_name           = "rg-aks-dev"
  aks_cluster_name      = "aks-fiap-soat-dev"
  aks_target_namespaces = ["fiap", "keda", "monitoring"]
}
