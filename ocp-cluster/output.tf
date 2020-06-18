output logdna_id {
  description = "GUID of LogDNA Instance"
  value       = "${ibm_resource_instance.logdna_instance.id}"
}

output sysdig_id {
  description = "GUID of Sysdig Instance"
  value       = "${ibm_resource_instance.sysdig_instance.id}"
}

output cluster_id {
  description = "ID of OCP Cluster"
  value       = "${ibm_container_cluster.cluster.id}"
}