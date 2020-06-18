locals {
  role              = "Manager"
}

data "ibm_resource_group" "resource_group" {
  name = "${var.resource_group}"
}


##############################################################################
# Creating LogDNA instance
##############################################################################

resource "ibm_resource_instance" "logdna_instance" {
  name              = "${var.unique_id}-logdna"
  service           = "logdna"
  plan              = "${var.logging_plan}"
  location          = "${var.ibm_region}"
  resource_group_id = "${data.ibm_resource_group.resource_group.id}"
  parameters = {
    service-endpoints = "${var.end_points}"
  }
}

data "ibm_resource_instance" "logdna_instance" {
  depends_on        = [ibm_resource_instance.logdna_instance]

  name              = "${var.unique_id}-logdna"
  resource_group_id = "${data.ibm_resource_group.resource_group.id}"
  location          = "${var.ibm_region}"
  service           = "logdna"
}

resource "ibm_resource_key" "logdna_instance_key" {
  name                 = "${data.ibm_resource_instance.logdna_instance.name}-key"
  resource_instance_id = data.ibm_resource_instance.logdna_instance.id
  role                 = local.role
}

##############################################################################
# Creating Sysdig instance
##############################################################################

resource "ibm_resource_instance" "sysdig_instance" {
  name              = "${var.unique_id}-sysdig"
  service           = "sysdig-monitor"
  plan              = var.sysdig_plan
  location          = "${var.ibm_region}"
  resource_group_id = "${data.ibm_resource_group.resource_group.id}"
}

##############################################################################
# Creating OCP Cluster 
##############################################################################

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
  #entitlement       = "cloud_pak"
}

data "ibm_container_cluster" "cluster" {
  depends_on        = [ibm_container_cluster.cluster]
  cluster_name_id = "${var.unique_id}-cluster"
}

data "ibm_container_cluster_config" "clusterConfig" {
  cluster_name_id = "${var.unique_id}-cluster"
  config_dir      = "/tmp"
}

##############################################################################
# Binding LogDNA to OCP Cluster
##############################################################################

resource "null_resource" "logdna_bind" {

  triggers = {
    namespace  = var.namespace
    KUBECONFIG = "${data.ibm_container_cluster_config.clusterConfig.config_file_path}"
  }

  provisioner "local-exec" {
    command = "${path.module}/scripts/bind-logdna.sh ${var.cluster_type} ${ibm_resource_key.logdna_instance_key.credentials.ingestion_key} ${var.ibm_region} ${var.namespace} ${var.service_account_name}"

    environment = {
      KUBECONFIG = self.triggers.KUBECONFIG
      TMP_DIR    = "${path.cwd}/.tmp"
    }
  }

  provisioner "local-exec" {
    when    = destroy
    command = "${path.module}/scripts/unbind-logdna.sh ${self.triggers.namespace}"

    environment = {
      KUBECONFIG = self.triggers.KUBECONFIG
    }
  }
}