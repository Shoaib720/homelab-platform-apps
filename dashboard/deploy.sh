#!/bin/bash

source ../functions.sh

NAMESPACE="management"

deploy_dashboard() {
    # Namespace
    if k8s_resource_exists namespace $NAMESPACE; then
        echo "INFO: $NAMESPACE namespace already exists. Skipping..."
    else
        echo "INFO: Creating namespace $NAMESPACE.."
        kubectl create namespace $NAMESPACE
    fi

    kubectl apply -f deployment.yml -n $NAMESPACE
    kubectl apply -f service.yml -n $NAMESPACE
    kubectl apply -f route.yml -n $NAMESPACE
}

deploy_dashboard