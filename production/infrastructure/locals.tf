locals {
  aks_rg_name           = "rg-aks-prod"
  aks_cluster_name      = "aks-fiap-soat-prod"
  aks_target_namespaces = ["fiap", "keda", "monitoring"]
}
