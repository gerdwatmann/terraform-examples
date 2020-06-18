variable resource_group {
  description = "Name of resource group to provision resources"
}

variable "ibmcloud_api_key" {
  description = "IBM Cloud API Key"
}

variable unique_id {
  description = "Prefix for all resources created in the module. Must begin with a letter."
  default     = "bootcamp"
}

##############################################################################
# LogDNA Logging Variables
##############################################################################

variable "logging_plan" {
  default = "30 day"
}

variable end_points {
  description = "Sets the endpoints for the resources provisioned. Can be `public` or `private`"
  default     = "public"
}

##############################################################################
# Sysdig Logging Variables
##############################################################################

variable "sysdig_plan" {
  description = "Plan for your Sysdig instance in IBM Cloud."
  default = "graduated-tier"
}


##############################################################################
# OpenShift Cluster Variables
##############################################################################

variable "machine_type" {
  default = "b2c.8x32"
}

variable "hardware" {
  default = "shared"
}

variable "datacenter" {
  default = "fra02"
}

variable "default_pool_size" {
  default = "3"
}

variable "private_vlan_id" {}

variable "public_vlan_id" {}

variable "cluster_name" {
  default = "cluster"
}
variable kube_version {
  default = "4.3_openshift"
}
##############################################################################


