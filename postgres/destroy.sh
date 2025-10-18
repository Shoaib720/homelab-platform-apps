#!/bin/bash

source ../functions.sh

NAMESPACE="postgres"

destroy_postgres() {
    kubectl delete -f svc.yml -n $NAMESPACE
    kubectl delete -f stateful.yml -n $NAMESPACE
    kubectl delete -f secrets.yml -n $NAMESPACE
    kubectl delete namespace $NAMESPACE
}

destroy_postgres