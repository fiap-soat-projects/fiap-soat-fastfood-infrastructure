output "host" {
  description = "The hostname (API server URL) of the AKS cluster."
  value       = azurerm_kubernetes_cluster.aks.kube_config[0].host
}

output "ca_certificate" {
  description = "Cluster CA certificate of the AKS cluster."
  value       = azurerm_kubernetes_cluster.aks.kube_config[0].cluster_ca_certificate
}
