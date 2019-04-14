resource "azuread_application" "k8s_application" {
  name                       = "bvb-test"
  available_to_other_tenants = false
  oauth2_allow_implicit_flow = true
}

resource "azuread_service_principal" "k8s_service_principal" {
  application_id = "${azuread_application.k8s_application.application_id}"
}

resource "azuread_service_principal_password" "k8s_service_principal_password" {
  service_principal_id = "${azuread_service_principal.k8s_service_principal.id}"
  value                = "00000000000000000000000000000000"
  end_date             = "2020-01-01T01:02:03Z"

  # Bug work around: wait some time for service principle to be ready before proceeding 
  # cfr https://github.com/terraform-providers/terraform-provider-azuread/issues/4
  provisioner "local-exec" {
    command = "sleep 30"
  }
}

resource "azurerm_kubernetes_cluster" "k8s_cluster" {
  name                = "${var.cluster_name}"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group}"
  dns_prefix          = "${var.cluster_dns_prefix}"

  agent_pool_profile {
    name            = "default"
    count           = "${var.cluster_vm_count}"
    vm_size         = "${var.cluster_vm_size}"
    os_type         = "Linux"
    os_disk_size_gb = 30
  }

  service_principal {
    client_id     = "${azuread_application.k8s_application.application_id}"
    client_secret = "${azuread_service_principal_password.k8s_service_principal_password.value}"
  }

  # Wait for flannel to be supported
  # network_profile {
  #   network_plugin = "flannel"
  # }

  tags = {
    Environment = "${var.environment}"
    User        = "${var.user}"
  }
}

data "external" "cluster_nodes_vnet_name" {
  program = ["bash", "${path.module}/scripts/get_vnet_name.sh", "${azurerm_kubernetes_cluster.k8s_cluster.node_resource_group}"]
}
