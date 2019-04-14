variable "bigip_admin_password" {
  description = "Password to login to the BigIP Virtual Machine"
}

variable "bigip_dns_label" {
  description = "Unique DNS Name for the Public IP address used to access the BigIP Virtual Machine"
}

variable "bigip_vnet_name" {
  description = "The name of the existing virtual network to which you want to connect the BigIP VEs"
}

variable "bigip_vnet_resource_group_name" {
  description = "The resource group of the existing virtual network to which you want to connect the BigIP VEs"
}

variable "bigip_mgmt_subnet_address_prefix" {
  description = "Address prefix of the mgmt subnet - with external access to the Internet"
}

variable "bigip_mgmt_ip_address" {
  description = "Managemnt subnet IP Address to use for the BigIP management IP address"
}
