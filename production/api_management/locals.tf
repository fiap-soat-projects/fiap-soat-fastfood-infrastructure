locals {
  apim_rg_name = "rg-apim-prod"
  apim_name    = "apim-fiap-soat-fastfood-prod"
}

locals {
  apim_auth_function_name = "fastfood-auth-function"

  auth_function_operations = {
    jwks         = { method = "GET", display_name = "jwks", template = "/.well-known/jwks.json" }
    openidconfig = { method = "GET", display_name = "open-id-config", template = "/.well-known/openid-configuration" }
    login        = { method = "POST", display_name = "login", template = "/login" }
  }
}

locals {
  fastfood_order_service_ip    = data.kubernetes_service.fastfood_order_service.status[0].load_balancer[0].ingress[0].ip
  fastfood_payment_service_ip  = data.kubernetes_service.fastfood_payment_service.status[0].load_balancer[0].ingress[0].ip
  fastfood_customer_service_ip = data.kubernetes_service.fastfood_customer_service.status[0].load_balancer[0].ingress[0].ip
}
