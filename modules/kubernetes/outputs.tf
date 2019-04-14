output "cluster_fqdn" {
  value = "${azurerm_kubernetes_cluster.k8s_cluster.fqdn}"
}

output "client_certificate" {
  value = "${azurerm_kubernetes_cluster.k8s_cluster.kube_config.0.client_certificate}"
}

output "kube_config" {
  value = "${azurerm_kubernetes_cluster.k8s_cluster.kube_config_raw}"
}

output "cluster_vnet_name" {
  value = "${data.external.cluster_vnet_name.result.name}"
}
