##############################################################################
# Using the IBM Terraform Provider
##############################################################################

provider "ibm" {
  generation        = 1
  ibmcloud_api_key  = var.ibmcloud_api_key
}


##############################################################################
# use resource group
##############################################################################

data "ibm_resource_group" "resource_group" {
  name = "${var.resource_group}"
}


##############################################################################
# create LogDNA instance
##############################################################################

resource ibm_resource_instance logdna {

  name              = "${var.unique_id}-logdna"
  service           = "logdna"
  plan              = "${var.logging_plan}"
  location          = "${var.ibm_region}"
  resource_group_id = "${data.ibm_resource_group.resource_group.id}"

  parameters = {
    service-endpoints = "${var.end_points}"
  }

}

##############################################################################