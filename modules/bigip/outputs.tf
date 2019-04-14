output "bigip_gui_url" {
  value = "${lookup(azurerm_template_deployment.bigip_azuredeploy.outputs, "guI-URL")}"
}

output "bigip_ssh_url" {
  value = "${lookup(azurerm_template_deployment.bigip_azuredeploy.outputs, "ssH-URL")}"
}
