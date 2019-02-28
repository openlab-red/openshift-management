# OpenShift Restore

Restore your OpenShift cluster.

## Tested on

| OpenShift Version   |
|---------------------|
|       3.9           |
|                     |
|       3.10          |
|                     |
|       3.11          |

## Extra Vars

|    Extra Vars          |  Description                                          |  Default  |
|------------------------|-------------------------------------------------------|-----------|
| restore_root           |   Where to get the backup content                     |  /restore |
| backup_prefix          |   Which backup to get                                 |           |


## Component to restore


|    Component           |  Variable           | Default                                   |   Tags   |
|------------------------|---------------------|-------------------------------------------|--------- |
| Node / Master content  | backup_node_content |                                           | masters <br> nodes    |
|                        |                     |                                           |          |
|         etcd           |          -          |   etcd snapshot and status                |   etcd   |
|                        |                     |                                           |          |

More details on [openshift-backup components](../openshift-backup/README.md)


## Usage


### Restore All

```
ansible-playbook -i inventory playbooks/openshift-restore/config.yaml -e backup_prefix=2019-02-28@13
```

#### AWS S3
>
>
> Be sure the env AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY are set
>
>

```
ansible-playbook -i inventory playbooks/openshift-restore/config.yaml -e backup_prefix=2019-02-28@13 -e aws_s3=true -e aws_s3_backup_bucket=eu-central-1-dev-openlab-red-backup -e aws_region=eu-central-1
```

### Restore Node and Masters

#### Nodes

```
ansible-playbook -i inventory playbooks/openshift-restore/config.yaml -e backup_prefix=2019-02-28@13 -t nodes
```

#### Masters Only

```
ansible-playbook -i inventory playbooks/openshift-restore/config.yaml -e backup_prefix=2019-02-28@13 -t masters -l masters
```

### Restore etcd

```
ansible-playbook -i inventory playbooks/openshift-restore/config.yaml -e backup_prefix=2019-02-28@13 -t etcd -l etcd
```
