# OpenShift Local Volume

|Playbooks                 |
|--------------------------|
|openshift-expand-pv/config.yml|


## Prerequisite

Create a volume and mount under */mnt/local-storage* for each node.

```
vgcreate  local-volume /dev/sdb
lvcreate -L 10G -n disk1 local-volume
mkfs.ext4 /dev/local-volume/disk1
mkdir -p /mnt/local-storage/local-volume/disk1
mount /dev/local-volume/disk1 /mnt/local-storage/local-volume/disk1
chcon -R unconfined_u:object_r:svirt_sandbox_file_t:s0 /mnt/local-storage/

```

With Ansible Check: [Provision LVM](../provision-lvm/README.md)

## References

* https://docs.openshift.com/container-platform/3.9/install_config/configuring_local.html#local-volume-enabling-local-volumes



