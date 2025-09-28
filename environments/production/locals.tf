locals {
  backend_rg_name        = "rg-terraform-prod"
  backend_sa_name        = "safiapsoatterraformprod"
  backend_container_name = "tfstate"
}

locals {
  aks_rg_name           = "rg-aks-prod"
  aks_cluster_name      = "aks-fiap-soat-prod"
  aks_target_namespaces = ["fiap", "keda", "monitoring"]
}
