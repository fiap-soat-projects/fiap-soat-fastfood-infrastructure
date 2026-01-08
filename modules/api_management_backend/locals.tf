locals {
  fastfood_api_operations = {
    get    = { method = "GET", display_name = "wildcard-proxy-get" }
    post   = { method = "POST", display_name = "wildcard-proxy-post" }
    patch  = { method = "PATCH", display_name = "wildcard-proxy-patch" }
    put    = { method = "PUT", display_name = "wildcard-proxy-put" }
    delete = { method = "DELETE", display_name = "wildcard-proxy-delete" }
  }
}
