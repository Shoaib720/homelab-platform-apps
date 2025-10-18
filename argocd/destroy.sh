#!/bin/bash

source ../functions.sh

NAMESPACE="argocd"

destroy_argocd() {
    helm uninstall argo-cd -n $NAMESPACE
    kubectl delete namespace $NAMESPACE
}

destroy_argocd