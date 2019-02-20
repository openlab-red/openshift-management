#!/bin/bash

if [[ "$#" -ne 1 ]]
then
    echo "Missing Etcd backup root parameters"
    exit 1
fi

ETCD_BACKUP_ROOT=$1

source /etc/etcd/etcd.conf
export ETCDCTL_API=3

# check state of etcd
systemctl show etcd --property=ActiveState,SubState

# get endpoints
ETCD_ALL_ENDPOINTS=`etcdctl --cert=${ETCD_PEER_CERT_FILE} \
    --key=${ETCD_PEER_KEY_FILE} \
    --cacert=${ETCD_TRUSTED_CA_FILE} \
    --endpoints=${ETCD_LISTEN_CLIENT_URLS} \
    --write-out=fields member list \
    | awk '/ClientURL/{printf "%s%s",sep,$3; sep=","}' | sed 's/"//g'`

# make snapshot
etcdctl --cert=${ETCD_PEER_CERT_FILE} \
    --key=${ETCD_PEER_KEY_FILE} \
    --cacert=${ETCD_TRUSTED_CA_FILE} \
    --endpoints ${ETCD_ALL_ENDPOINTS} snapshot save ${ETCD_BACKUP_ROOT}/db

# snapshot status
etcdctl --cert=${ETCD_PEER_CERT_FILE} \
    --key=${ETCD_PEER_KEY_FILE} \
    --cacert=${ETCD_TRUSTED_CA_FILE} \
    --endpoints ${ETCD_ALL_ENDPOINTS} snapshot status ${ETCD_BACKUP_ROOT}/db | tee ${ETCD_BACKUP_ROOT}/status

if [[ "$?" -ne 0 ]]
then
    echo "${ETCD_BACKUP_ROOT}/db is not a valid etcd backup. Please check the status of your etcd cluster"
    exit 1
fi


