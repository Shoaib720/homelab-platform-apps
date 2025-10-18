#!/bin/bash

source ../functions.sh

# Variables (customize these paths and values)
NAMESPACE="traefik"
SECRET_NAME="deploywizard-in-tls"
CRT_FILE="./certs/fullchain.pem"
KEY_FILE="./certs/private.pem"

deploy_traefik() {

    # Check that cert files exist
    if [[ ! -f "$CRT_FILE" || ! -f "$KEY_FILE" ]]; then
        echo "Error: One or both certificate files not found."
        echo "Expected: $CRT_FILE and $KEY_FILE"
        exit 1
    fi

    # Namespace
    if k8s_resource_exists namespace $NAMESPACE; then
        echo "INFO: $NAMESPACE namespace already exists. Skipping..."
    else
        echo "INFO: Creating namespace $NAMESPACE.."
        kubectl create namespace $NAMESPACE
    fi

    # Secret
    if k8s_resource_exists secret $SECRET_NAME $NAMESPACE; then
        echo "INFO: $SECRET_NAME secret already exists. Skipping..."
    else
        echo "INFO: Creating secret $SECRET_NAME.."
        
        kubectl -n "$NAMESPACE" create secret tls "$SECRET_NAME" \
            --cert="$CRT_FILE" \
            --key="$KEY_FILE"
    fi

    helm repo add traefik https://traefik.github.io/charts

    helm upgrade --install traefik traefik/traefik --version 37.1.2 -n $NAMESPACE -f values.yml \
    --set tlsStore.default.defaultCertificate.secretName=$SECRET_NAME
}

deploy_traefik