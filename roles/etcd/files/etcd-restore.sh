#!/bin/bash

if [[ "$#" -ne 1 ]]
then
    echo "Missing Etcd backup root parameters"
    exit 1
fi

ETCD_BACKUP_ROOT=$1

# Load etcd configuration
source /etc/etcd/etcd.conf
export ETCDCTL_API=3

#Default value
ETCD_DATA_DIR=${ETCD_DATA_DIR-/var/lib/etcd}
ETCD_DATA_DIR_TMP=${ETCD_DATA_DIR}_tmp/

if [[ -z "${ETCD_DATA_DIR}" ]]
then
    echo "Please set \$ETCD_DATA_DIR"
    exit 1
else
    # Never umount the volume
    rm -fr ${ETCD_DATA_DIR}/*

    etcdctl snapshot restore ${ETCD_BACKUP_ROOT} \
      --name ${ETCD_NAME} \
      --data-dir ${ETCD_DATA_DIR_TMP} \
      --initial-cluster ${ETCD_INITIAL_CLUSTER} \
      --initial-cluster-token ${ETCD_INITIAL_CLUSTER_TOKEN} \
      --initial-advertise-peer-urls ${ETCD_INITIAL_ADVERTISE_PEER_URLS} \
      --debug=true

    cp -a ${ETCD_DATA_DIR_TMP}/* ${ETCD_DATA_DIR}/
    chown -R etcd:etcd ${ETCD_DATA_DIR}
    restorecon -R ${ETCD_DATA_DIR}
    rm -fr ${ETCD_DATA_DIR_TMP}
fi
