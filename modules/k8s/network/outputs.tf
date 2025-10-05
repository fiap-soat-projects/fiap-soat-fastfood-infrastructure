output "subnet_id" {
  description = "The ID of the subnet created for AKS and NAT Gateway"
  value       = azurerm_subnet.subnet.id
}

output "inbound_ip" {
  description = "Public Static Inbound IP for NAT Gateway."
  value       = azurerm_public_ip.aks_inbound_ip.ip_address
}

output "outbound_ip" {
  description = "Public Static Outbound IP for AKS, used for whitelisting in MongoDB Atlas."
  value       = azurerm_public_ip.aks_outbound_ip.ip_address
}
