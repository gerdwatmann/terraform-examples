##############################################################################
# Sensitive Account Variables
##############################################################################

variable ibmcloud_api_key {
  description = "The IBM Cloud platform API key needed to deploy IAM enabled resources"
  default     = "REPLACE---ADD_YOUR_API_KEY"
}

##############################################################################


##############################################################################
# Account Variables
##############################################################################

variable ibm_region {
  description = "IBM Cloud region where all resources will be deployed"
  default     = "eu-de"
}

variable resource_group {
  description = "Name of resource group to provision resources"
  default     = "REPLACE---ADD_YOUR_RESOURCE_GROUP"
}

variable unique_id {
  description = "Prefix for all resources created in the module. Must begin with a letter."
  default     = "REPLACE---ADD_YOUR_INITIALS"
}

##############################################################################


##############################################################################
# Resource Service Endpoints
##############################################################################

variable end_points {
  description = "Sets the endpoints for the resources provisioned. Can be `public` or `private`"
  default     = "public"
}

##############################################################################


##############################################################################
# Logging and Monitoring Variables
##############################################################################

variable logging_plan {
  description = "service plan for LogDNA, Activity Tracker."
  default     = "7-day"
}

##############################################################################