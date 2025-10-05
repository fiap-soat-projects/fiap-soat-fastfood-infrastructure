locals {
  apim_rg_name = "rg-apim-dev"
  apim_name    = "apim-fiap-soat-fastfood-dev"
}

locals {
  apim_auth_function_name = "fastfood-auth-function"

  auth_function_operations = {
    jwks         = { method = "GET", display_name = "jwks", tempalte = "/.well-known/jwks.json" }
    openidconfig = { method = "GET", display_name = "open-id-config", tempalte = "/.well-known/openid-configuration" }
    login        = { method = "POST", display_name = "login", tempalte = "/login" }
  }
}

locals {
  apim_fastfood_backend_name = "fastfood-api-backend"

  fastfood_api_operations = {
    get    = { method = "GET", display_name = "wildcard-proxy-get" }
    post   = { method = "POST", display_name = "wildcard-proxy-post" }
    patch  = { method = "PATCH", display_name = "wildcard-proxy-patch" }
    put    = { method = "PUT", display_name = "wildcard-proxy-put" }
    delete = { method = "DELETE", display_name = "wildcard-proxy-delete" }
  }
}

locals {
  fastfood_service_ip = data.kubernetes_service.fastfood_service.status[0].load_balancer[0].ingress[0].ip
}
