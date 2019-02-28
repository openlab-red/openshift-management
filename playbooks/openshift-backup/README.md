# OpenShift Backup

Backup your OpenShift cluster.

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
| backup_root            |   Where to save the backup content                    |   /backup |
| aws_s3                 |   Enable AWS S3 sync                                  |   false   |
| aws_s3_backup_bucket   |   S3 backup                                           |           |
| aws_region             |   AWS Region                                          |           |


## Component to backup

|    Component           |  Variable           | Default                                   |   Tags   |
|------------------------|---------------------|-------------------------------------------|--------- |
| Node/Master pkg list |  -                  | "rpm -qa \| sort \| tee"                  | packages<br>nodes|
|                        |                     |                                           |          |
| Node/Master content  | backup_node_content | - /etc/origin <br>  - /etc/etcd <br>  - /etc/sysconfig <br>  - /etc/cni <br>  - /etc/dnsmasq.d <br>  - /etc/pki/ca-trust/source/anchors <br>  - /etc/docker/certs.d <br>  - /etc/dnsmasq.conf | nodes    |
|                        |                     |                                           |          |
|         etcd           |          -          |   etcd snapshot and status                |   etcd   |
|                        |                     |                                           |          |  
|        Project         |          -          | ns <br> rolebindings <br> serviceaccounts <br> secrets <br> dcs <br> bcs <br> builds <br> is <br> rcs <br> svcs <br> pods <br> cms <br> pvcs <br> pvcs_attachment <br> routes <br> templates  <br> egressnetworkpolicies <br> imagestreamtags <br> rolebindingrestrictions <br> limitranges  <br> resourcequotas <br> podpreset <br> cronjobs <br> statefulsets <br> hpas<br> deployments <br> replicasets <br> poddisruptionbudget <br> daemonset | project |

All components are saved under the *backup_root/YYYY-MM-DD@HH*

For instances:

```
backup/
└── 2019-02-28@14
    ├── ip-172-16-18-63.eu-central-1.compute.internal
    │   └── backup.tar
    ├── ip-172-16-18-12.eu-central-1.compute.internal
    │   ├── backup.tar
    │   ├── etcd.tar
    │   └── openshift-project.tar
    ├── ip-172-16-32-10.eu-central-1.compute.internal
    │   └── backup.tar
    ├── ip-172-16-55-14.eu-central-1.compute.internal
    │   └── backup.tar
    └── ip-172-16-82-171.eu-central-1.compute.internal
        └── backup.tar
```

>
>The node *ip-172-16-18-12.eu-central-1.compute.internal* is the first master.
>

|Archive| Description|
|-------|------------|
|backup.tar| Node/Master content and pkg list|
|etcd.tar| etcd snapshot|
|opeshift-project.tar| project information|

## Usage


### Backup All

```
ansible-playbook -i inventory playbooks/openshift-backup/config.yaml -e backup_root=/backup
```

#### AWS S3

>
> Be sure the env AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY are set
>

```
ansible-playbook -i inventory playbooks/openshift-backup/config.yaml -e backup_root=/backup -e aws_s3=true -e aws_s3_backup_bucket=eu-central-1-dev-openlab-red-backup -e aws_region=eu-central-1
```

### Backup Nodes

#### Nodes

```
ansible-playbook -i inventory playbooks/openshift-backup/config.yaml -e backup_root=/backup -t nodes
```

#### Master Only

```
ansible-playbook -i inventory playbooks/openshift-backup/config.yaml -e backup_root=/backup -t nodes -l masters
```

### Backup etcd

```
ansible-playbook -i inventory playbooks/openshift-backup/config.yaml -e backup_root=/backup -t etcd -l etcd
```

### Backup Project 

```
ansible-playbook -i inventory playbooks/openshift-backup/config.yaml -e backup_root=/backup -t project -l masters[0]
```



















