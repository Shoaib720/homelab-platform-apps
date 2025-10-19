#!/bin/bash

source ../functions.sh

destroy_cluster_resources() {
    kubectl delete -f peristent-storageclass.yml
    kubectl delete -f volumesnapshotclass.yml
}

destroy_cluster_resources