#!/bin/bash

source ../functions.sh

NAMESPACE="keycloak"

destroy_postgres() {
    kubectl delete -f route.yml -n $NAMESPACE
    kubectl delete -f svc.yml -n $NAMESPACE
    kubectl delete -f deployment.yml -n $NAMESPACE
    kubectl delete -f servers-cm.yml -n $NAMESPACE
    kubectl delete -f secrets.yml -n $NAMESPACE
    kubectl delete namespace $NAMESPACE
}

destroy_postgres