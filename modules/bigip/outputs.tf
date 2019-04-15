output "bigip_arm_output" {
  value = "${azurerm_template_deployment.bigip_azuredeploy.outputs}"
}
