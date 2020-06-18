
data "ibm_resource_group" "resource_group" {
  name = "${var.resource_group}"
}

resource "ibm_resource_instance" "logdna" {
  name              = "${var.unique_id}-logdna"
  service           = "logdna"
  plan              = "${var.logging_plan}"
  location          = "${var.ibm_region}"
  resource_group_id = "${data.ibm_resource_group.resource_group.id}"
  parameters = {
    service-endpoints = "${var.end_points}"
  }
}

resource "ibm_resource_instance" "sysdig" {
  name              = "${var.unique_id}-sysdig"
  service           = "sysdig-monitor"
  plan              = var.sysdig_plan
  location          = "${var.ibm_region}"
  resource_group_id = "${data.ibm_resource_group.resource_group.id}"
}

resource "ibm_container_cluster" "cluster" {
  resource_group_id = "${data.ibm_resource_group.resource_group.id}"
  name              = "${var.unique_id}-cluster"
  datacenter        = "${var.datacenter}"
  default_pool_size = "${var.default_pool_size}"
  machine_type      = "${var.machine_type}"
  hardware          = "${var.hardware}"
  kube_version      = "${var.kube_version}"
  public_vlan_id    = "${var.public_vlan_id}"
  private_vlan_id   = "${var.private_vlan_id}"  
  entitlement       = "cloud_pak"
}