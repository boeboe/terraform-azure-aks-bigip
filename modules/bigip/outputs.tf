output "bigip_gui_url" {
  value = "${lookup(azurerm_template_deployment.bigip_azuredeploy.outputs, "GUI-URL")}"
}

output "bigip_ssh_url" {
  value = "${lookup(azurerm_template_deployment.bigip_azuredeploy.outputs, "SSH-URL")}"
}
