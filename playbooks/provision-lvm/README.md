# Provision LVM

|Playbooks                 |
|--------------------------|
|provision-lvm/config.yml|


## Parameters

```
    provision_lvm_list:
      - name: disk1
        disksize: 10G
        group: local-volume
        mount_root_point: /mnt/local-storage
```

## References

* https://docs.openshift.com/container-platform/3.9/install_config/configuring_local.html#local-volume-enabling-local-volumes



