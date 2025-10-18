#!/bin/bash

source ../functions.sh

NAMESPACE="postgres"

deploy_postgres() {
    # Namespace
    if k8s_resource_exists namespace $NAMESPACE; then
        echo "INFO: $NAMESPACE namespace already exists. Skipping..."
    else
        echo "INFO: Creating namespace $NAMESPACE.."
        kubectl create namespace $NAMESPACE
    fi

    kubectl apply -f secrets.yml -n $NAMESPACE
    kubectl apply -f statefulset.yml -n $NAMESPACE
    kubectl apply -f svc.yml -n $NAMESPACE
}

deploy_postgres