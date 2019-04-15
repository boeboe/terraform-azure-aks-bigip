output "cluster_fqdn" {
  value = "${module.kubernetes.cluster_fqdn}"
}

output "client_certificate" {
  value = "${module.kubernetes.client_certificate}"
}

output "kube_config" {
  value = "${module.kubernetes.kube_config}"
}

output "bigip_arm_output" {
  value = "${module.bigip.bigip_arm_output}"
}
