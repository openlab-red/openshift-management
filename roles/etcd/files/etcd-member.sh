#!/bin/bash

if [[ "$#" -ne 2 ]]
then
    echo "Missing Etcd parameters for member add"
    exit 1
fi

ETCD_MEMBER_NAME="$1"
ETCD_MEMBER_PEER_URLS="$2"

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


etcdctl --cert=$ETCD_PEER_CERT_FILE --key=$ETCD_PEER_KEY_FILE --cacert=$ETCD_TRUSTED_CA_FILE --endpoints=$ETCD_ALL_ENDPOINTS \
    member add ${ETCD_MEMBER_NAME} --peer-urls=${ETCD_MEMBER_PEER_URLS}
