module "namespaces" {
  source     = "../../modules/k8s/namespace"
  namespaces = local.aks_target_namespaces
}
