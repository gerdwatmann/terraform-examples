##############################################################################
# GeneralVariables
##############################################################################

variable "resource_group" {
  description = "Name of resource group to provision resources"
}

variable "ibmcloud_api_key" {
  description = "IBM Cloud API Key. Got it working with user based api key that has to include an infra key!"
}

variable "unique_id" {
  description = "Prefix for all resources created in the module. Must begin with a letter."
}

variable "ibm_region" {
  default = "eu-de"
}


##############################################################################
# Sysdig Logging Variables
##############################################################################

variable "sysdig_plan" {
  description = "Plan for your Sysdig instance in IBM Cloud."
  default = "graduated-tier"
}