terraform {
  required_version = "~> 0.11"

  # backend "azurerm" {
  #   storage_account_name = "f5-demo-aks-bvb"
  #   container_name       = "tfstate"
  #   key                  = "f5-demo-aks-bvb.terraform.tfstate"
  # }
}

provider "azurerm" {
  version = "=1.24.0"
}

provider "azuread" {
  version = "=0.1.0"
}

provider "template" {
  version = "~> 1.0"
}

# data "template_file" "policy_rule_tag_env" {
#   template = "${file("templates/policy_rule.json")}"

#   vars {
#     tag_name = "Environment"
#   }
# }

# data "template_file" "policy_rule_tag_user" {
#   template = "${file("templates/policy_rule.json")}"

#   vars {
#     tag_name = "User"
#   }
# }

# resource "azurerm_policy_definition" "recursive_tag_policy_definition_env" {
#   name         = "recursive-tag-policy-definition-env"
#   policy_type  = "Custom"
#   mode         = "Indexed"
#   display_name = "recursive-tag-policy-definition-env"
#   policy_rule  = "${data.template_file.policy_rule_tag_env.rendered}"
# }

# resource "azurerm_policy_definition" "recursive_tag_policy_definition_user" {
#   name         = "recursive-tag-policy-definition-user"
#   policy_type  = "Custom"
#   mode         = "Indexed"
#   display_name = "recursive-tag-policy-definition-user"
#   policy_rule  = "${data.template_file.policy_rule_tag_user.rendered}"
# }

resource "azurerm_resource_group" "resource_group" {
  name     = "${var.resource_group}"
  location = "${var.location}"

  tags = {
    Environment = "${var.environment}"
    User        = "${var.user}"
  }
}

# resource "azurerm_policy_assignment" "recursive_tag_policy_assignment_env" {
#   name                 = "recursive-tag-policy-assignment-env"
#   scope                = "${azurerm_resource_group.resource_group.id}"
#   policy_definition_id = "${azurerm_policy_definition.recursive_tag_policy_definition_env.id}"
#   description          = "Policy Assignment to inherit Environment Tag"
#   display_name         = "Environment Tag Inheritance"
# }

# resource "azurerm_policy_assignment" "recursive_tag_policy_assignment_user" {
#   name                 = "recursive-tag-policy-assignment-user"
#   scope                = "${azurerm_resource_group.resource_group.id}"
#   policy_definition_id = "${azurerm_policy_definition.recursive_tag_policy_definition_user.id}"
#   description          = "Policy Assignment to inherit User Tag"
#   display_name         = "User Tag Inheritance"
# }

module "kubernetes" {
  source = "modules/kubernetes"

  environment        = "${var.environment}"
  user               = "${var.user}"
  location           = "${azurerm_resource_group.resource_group.location}"
  resource_group     = "${azurerm_resource_group.resource_group.name}"
  cluster_name       = "${var.cluster_name}"
  cluster_dns_prefix = "${var.cluster_dns_prefix}"
  cluster_vm_count   = "${var.cluster_vm_count}"
  cluster_vm_size    = "${var.cluster_vm_size}"
}
