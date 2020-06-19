##############################################################################
# LogDNA Resource Instance ID
##############################################################################

output sysdig_id {
  description = "GUID of Sysdig Instance"
  value       = "${ibm_resource_instance.sysdig_instance.id}"
}

##############################################################################
