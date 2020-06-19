##############################################################################
# Using the IBM Terraform Provider
##############################################################################

provider "ibm" {
  generation        = 1
  ibmcloud_api_key  = var.ibmcloud_api_key
}

locals {
  role              = "Manager"
}


##############################################################################
# use resource group
##############################################################################

data "ibm_resource_group" "resource_group" {
  name = "${var.resource_group}"
}


##############################################################################
# create Sysdig instance
##############################################################################

resource "ibm_resource_instance" "sysdig_instance" {
  name              = "${var.unique_id}-sysdig"
  service           = "sysdig-monitor"
  plan              = var.sysdig_plan
  location          = "${var.ibm_region}"
  resource_group_id = "${data.ibm_resource_group.resource_group.id}"
}

data "ibm_resource_instance" "sysdig_instance" {
  depends_on        = [ibm_resource_instance.sysdig_instance]

  name              = "${var.unique_id}-sysdig"
  resource_group_id = "${data.ibm_resource_group.resource_group.id}"
  location          = "${var.ibm_region}"
  service           = "sysdig-monitor"
}

resource "ibm_resource_key" "sysdig_instance_key" {
  name                 = "${data.ibm_resource_instance.sysdig_instance.name}-key"
  resource_instance_id = data.ibm_resource_instance.sysdig_instance.id
  role                 = local.role
}

##############################################################################