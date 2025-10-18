#!/bin/bash

source ../functions.sh

NAMESPACE="velero"

deploy_velero() {
    # Namespace
    if k8s_resource_exists namespace $NAMESPACE; then
        echo "INFO: $NAMESPACE namespace already exists. Skipping..."
    else
        echo "INFO: Creating namespace $NAMESPACE.."
        kubectl create namespace $NAMESPACE
    fi

    helm repo add vmware-tanzu https://vmware-tanzu.github.io/helm-charts/
    helm upgrade --install velero vmware-tanzu/velero --version 11.1.1 -n $NAMESPACE -f values.yml
}

deploy_velero