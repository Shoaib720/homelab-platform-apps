#!/bin/bash

source ../functions.sh

NAMESPACE="velero"

destroy_velero() {
    helm uninstall velero -n $NAMESPACE
    kubectl delete namespace $NAMESPACE
}

destroy_velero