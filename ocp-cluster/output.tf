output logdna_id {
  description = "GUID of LogDNA Instance"
  value       = "${ibm_resource_instance.logdna.id}"
}

output sysdig_id {
  description = "GUID of Sysdig Instance"
  value       = "${ibm_resource_instance.sysdig.id}"
}

output cluster_id {
  description = "ID of OCP Cluster"
  value       = "${ibm_container_cluster.cluster.id}"
}