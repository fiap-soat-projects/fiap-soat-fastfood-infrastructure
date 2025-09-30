output "host" {
  value     = module.cluster.host
  sensitive = true
}

output "ca_certificate" {
  value     = module.cluster.ca_certificate
  sensitive = true
}

output "aks_ip" {
  value = module.network.outbound_ip
}

output "tenantid_id" {
  value = var.tenantid_id
}

output "aks_aad_server_id" {
  value = var.aks_aad_server_id
}
