#!/bin/bash

source ../functions.sh

NAMESPACE="pgadmin"

deploy_pgadmin() {
    # Namespace
    if k8s_resource_exists namespace $NAMESPACE; then
        echo "INFO: $NAMESPACE namespace already exists. Skipping..."
    else
        echo "INFO: Creating namespace $NAMESPACE.."
        kubectl create namespace $NAMESPACE
    fi

    kubectl apply -f pvc.yml -n $NAMESPACE
    kubectl apply -f secrets.yml -n $NAMESPACE
    kubectl apply -f deployment.yml -n $NAMESPACE
    kubectl apply -f svc.yml -n $NAMESPACE
    kubectl apply -f route.yml -n $NAMESPACE
}

deploy_pgadmin