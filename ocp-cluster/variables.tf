variable resource_group {
  description = "Name of resource group to provision resources"
}

variable "ibmcloud_api_key" {
  description = "IBM Cloud API Key with those permissions - https://cloud.ibm.com/docs/openshift?topic=openshift-access_reference#cluster_create_permissions"
}

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
  default = "bootcamp-cluster"
}
variable kube_version {
  default = "4.3_openshift"
}

