#!/bin/bash

source ../functions.sh

NAMESPACE="traefik"
SECRET_NAME="deploywizard-in-tls"

destroy_traefik() {
    helm uninstall traefik -n $NAMESPACE
    # Secret
    if k8s_resource_exists secret $SECRET_NAME $NAMESPACE; then
        echo "INFO: Deleting secret $SECRET_NAME ..."
        kubectl delete secret "$SECRET_NAME" -n "$NAMESPACE"
    else
        echo "INFO: Secret $SECRET_NAME does not exists."
    fi
    kubectl delete namespace $NAMESPACE
}

destroy_traefik