module "backend" {
  source         = "../../modules/backend"
  rg_name        = local.backend_rg_name
  sa_name        = local.backend_sa_name
  container_name = local.backend_container_name
}

module "cluster" {
  source           = "../../modules/k8s/cluster"
  subscription_id  = var.subscription_id
  tenantid_id      = var.tenantid_id
  location         = var.location
  aks_rg_name      = local.aks_rg_name
  aks_cluster_name = local.aks_cluster_name
}

module "namespaces" {
  source     = "../../modules/k8s/namespace"
  namespaces = local.aks_target_namespaces
  depends_on = [module.cluster]
}
