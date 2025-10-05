locals {
  apim_rg_name = "rg-apim-dev"
  apim_name    = "apim-fiap-soat-fastfood-dev"
}

locals {
  apim_backend_name = "fastfood-api-backend"
}

locals {
  fastfood_service_ip = data.kubernetes_service.fastfood_service.status[0].load_balancer[0].ingress[0].ip
}

locals {
  fastfood_api_operations = {
    get    = { method = "GET", display_name = "wildcard-proxy-get" }
    post   = { method = "POST", display_name = "wildcard-proxy-post" }
    patch  = { method = "PATCH", display_name = "wildcard-proxy-patch" }
    put    = { method = "PUT", display_name = "wildcard-proxy-put" }
    delete = { method = "DELETE", display_name = "wildcard-proxy-delete" }
  }
}
