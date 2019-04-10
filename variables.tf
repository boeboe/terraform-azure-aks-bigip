variable "environment" {
  description = "The name of your environment"
}

variable "user" {
  description = "The user responsible for your environment"
}

variable "location" {
  description = "The location of the data center to use"
}

variable "resource_group" {
  description = "The name of the resource group used in this demo"
}

variable "cluster_name" {
  description = "The name of your AKS Kubernetes Cluster"
}

variable "cluster_dns_prefix" {
  description = "The DNS prefix of your AKS Kubernetes Cluster"
}

variable "cluster_vm_count" {
  description = "Number of Agents (VMs) in the AKS Agent Pool."
}

variable "cluster_vm_size" {
  description = "The size of each VM in the AKS Agent Pool"
}
