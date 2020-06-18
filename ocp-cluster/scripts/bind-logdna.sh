#!/usr/bin/env bash

SCRIPT_DIR=$(cd $(dirname $0); pwd -P)
MODULE_DIR=$(cd ${SCRIPT_DIR}/..; pwd -P)

CLUSTER_TYPE="$1"
LOGDNA_AGENT_KEY="$2"
REGION="$3"
NAMESPACE="$4"
SERVICE_ACCOUNT_NAME="$5"

if [[ -n "${KUBECONFIG_IKS}" ]]; then
   export KUBECONFIG="${KUBECONFIG_IKS}"
fi

if [[ -z "${TMP_DIR}" ]]; then
   TMP_DIR="${MODULE_DIR}/.tmp"
fi

mkdir -p ${TMP_DIR}
YAML_FILE=${TMP_DIR}/logdna-agent-key.yaml

if [[ "${CLUSTER_TYPE}" == "kubernetes" ]]; then
    LOGDNA_AGENT_DS_YAML="https://assets.${REGION}.logging.cloud.ibm.com/clients/logdna-agent-ds.yaml"
else
    LOGDNA_AGENT_DS_YAML="https://assets.${REGION}.logging.cloud.ibm.com/clients/logdna-agent-ds-os.yaml"
fi

echo "*** Creating Namespace"
oc adm new-project --node-selector='' "${NAMESPACE}"

echo "*** Create Service Account"
oc create serviceaccount "${SERVICE_ACCOUNT_NAME}" -n "${NAMESPACE}"

echo "*** Set privileged access"
oc adm policy add-scc-to-user privileged system:serviceaccount:"${NAMESPACE}":"${SERVICE_ACCOUNT_NAME}"

echo "*** Creating logdna-agent-key secret in ${NAMESPACE}"
oc create secret generic logdna-agent-key -n "${NAMESPACE}" --from-literal=logdna-agent-key="${LOGDNA_AGENT_KEY}"

echo "*** Creating logdna-agent daemon set in ${NAMESPACE}"
oc apply -n "${NAMESPACE}" -f "${LOGDNA_AGENT_DS_YAML}"