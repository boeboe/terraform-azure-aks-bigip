output "cluster_fqdn" {
  value = "${module.kubernetes.cluster_fqdn}"
}

output "client_certificate" {
  value = "${module.kubernetes.client_certificate}"
}

output "kube_config" {
  value = "${module.kubernetes.kube_config}"
}

output "bigip_gui_url" {
  value = "${module.bigip.bigip_gui_url}"
}

output "bigip_ssh_url" {
  value = "${module.bigip.bigip_ssh_url}"
}
