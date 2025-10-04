locals {
  aks_rg_name           = "rg-aks-dev"
  aks_cluster_name      = "aks-fiap-soat-dev"
  aks_target_namespaces = ["fiap", "keda", "monitoring"]
}
