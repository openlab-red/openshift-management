#!/bin/bash

# Load etcd configuration
source /etc/etcd/etcd.conf
export ETCDCTL_API=3


# get endpoints
ETCD_ALL_ENDPOINTS=`etcdctl --cert=${ETCD_PEER_CERT_FILE} \
    --key=${ETCD_PEER_KEY_FILE} \
    --cacert=${ETCD_TRUSTED_CA_FILE} \
    --endpoints=${ETCD_LISTEN_CLIENT_URLS} \
    --write-out=fields member list \
    | awk '/ClientURL/{printf "%s%s",sep,$3; sep=","}' | sed 's/"//g'`


etcdctl --cert=$ETCD_PEER_CERT_FILE --key=$ETCD_PEER_KEY_FILE --cacert=$ETCD_TRUSTED_CA_FILE --endpoints=$ETCD_ALL_ENDPOINTS  --write-out=simple endpoint status |grep true| awk -F"," '{print $1}'| sed 's/https:\/\///'|sed 's/:2379//'