#!/bin/bash

source ../functions.sh

NAMESPACE="keycloak"

deploy_keycloak() {

    # Namespace
    if k8s_resource_exists namespace $NAMESPACE; then
        echo "INFO: $NAMESPACE namespace already exists. Skipping..."
    else
        echo "INFO: Creating namespace $NAMESPACE.."
        kubectl create namespace $NAMESPACE
    fi

    helm repo add codecentric https://codecentric.github.io/helm-charts

    kubectl apply -f secrets.yml -n $NAMESPACE

    helm upgrade --install keycloak codecentric/keycloakx --version 7.1.4 -n $NAMESPACE -f values.yml

    kubectl apply -f route.yml -n $NAMESPACE
}

deploy_keycloak