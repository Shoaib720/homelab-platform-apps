#!/bin/bash

source ../functions.sh

deploy_cluster_resources() {
    kubectl apply -f peristent-storageclass.yml
    # kubectl apply -f volumesnapshotclass.yml
}

deploy_cluster_resources