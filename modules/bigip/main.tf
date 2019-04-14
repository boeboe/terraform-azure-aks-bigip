resource "azurerm_subnet" "bigip_mgmt_subnet" {
  name                 = "bigip_mgmt_subnet"
  resource_group_name  = "${var.bigip_vnet_resource_group_name}"
  virtual_network_name = "${var.bigip_vnet_name}"
  address_prefix       = "${var.bigip_mgmt_subnet_address_prefix}"
}

data "template_file" "bigip_azuredeploy_parameters" {
  template = "${file("${path.module}/templates/azuredeploy.parameters.json")}"

  vars {
    bigip_admin_password           = "${var.bigip_admin_password}"
    bigip_dns_label                = "${var.bigip_dns_label}"
    bigip_vnet_name                = "${var.bigip_vnet_name}"
    bigip_vnet_resource_group_name = "${var.bigip_vnet_resource_group_name}"
    bigip_mgmt_subnet_name         = "${azurerm_subnet.bigip_mgmt_subnet.name}"
    bigip_mgmt_ip_address          = "${var.bigip_mgmt_ip_address}"
  }
}

resource "azurerm_template_deployment" "bigip_azuredeploy" {
  name                = "bigip_azuredeploy"
  resource_group_name = "${var.bigip_vnet_resource_group_name}"

  template_body   = "${file("${path.module}/files/azuredeploy.json")}"
  parameters_body = "${data.template_file.bigip_azuredeploy_parameters.rendered}"

  deployment_mode = "Incremental"
}
