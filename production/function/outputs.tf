output "name" {
  value = local.azfunc_name
}

output "rg" {
  value = local.azfunc_rg_name
}

output "url" {
  value = module.azfunc.azfunc_url
}

output "key_vault_uri" {
  value = azurerm_key_vault.auth_kv.vault_uri
}

output "auth_rsa_key_full_id" {
  value = azurerm_key_vault_key.auth_kv_rsa_key.id
}
