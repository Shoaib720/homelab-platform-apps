#!/bin/bash

source ../functions.sh

NAMESPACE="argocd"

deploy_argocd() {
    # Namespace
    if k8s_resource_exists namespace $NAMESPACE; then
        echo "INFO: $NAMESPACE namespace already exists. Skipping..."
    else
        echo "INFO: Creating namespace $NAMESPACE.."
        kubectl create namespace $NAMESPACE
    fi

    helm repo add argo https://argoproj.github.io/argo-helm
    helm upgrade --install argo-cd argo/argo-cd --version 9.0.1 -n $NAMESPACE -f values.yml
    kubectl apply -f route.yml -n $NAMESPACE
}

deploy_argocd