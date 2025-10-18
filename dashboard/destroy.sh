#!/bin/bash

source ../functions.sh

NAMESPACE="management"

destroy_dashboard() {
    kubectl delete -f route.yml -n $NAMESPACE
    kubectl delete -f service.yml -n $NAMESPACE
    kubectl delete -f deployment.yml -n $NAMESPACE
    kubectl delete namespace $NAMESPACE
}

destroy_dashboard