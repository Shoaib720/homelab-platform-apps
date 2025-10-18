#!/bin/bash

source ../functions.sh

NAMESPACE="pgadmin"

destroy_postgres() {
    kubectl delete -f route.yml -n $NAMESPACE
    kubectl delete -f svc.yml -n $NAMESPACE
    kubectl delete -f deployment.yml -n $NAMESPACE
    kubectl delete -f pvc.yml -n $NAMESPACE
    kubectl delete -f secrets.yml -n $NAMESPACE
    kubectl delete namespace $NAMESPACE
}

destroy_postgres