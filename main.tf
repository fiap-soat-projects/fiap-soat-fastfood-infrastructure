module "backend" {
  source         = "./modules/backend"
  rg_name        = local.backend_rg_name
  sa_name        = local.backend_sa_name
  container_name = local.backend_container_name
}

