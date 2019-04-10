# OpenShift Masters -  Debug & Collect Logs
 
## Requirements

OpenShift version 3.10 or 3.11.

## Increase the log

```
ansible-playbook -i inventory playbooks/master-log/config.yaml -t loglevel -e debug_loglevel=6
```

## Do your test case
 
Wait the api and controller to be up and running again, before proceed.

## Collect the logs
 

```
ansible-playbook -i inventory playbooks/master-log/config.yaml -t collect,fetch
``` 

Logs are saved under /tmp/master-logs/ of your ansible host, for each master `<hostname>.tar.gz`.
It contains OpenShift Master API, Controllers  and ETCD logs.

## Unarchive the logs
 

```
ansible-playbook -i inventory playbooks/master-log/config.yaml -t unarchive

ls -l /tmp/master-logs/
drwxr-xr-x. 2 root    root         60 Apr 10 13:16 ip-10-152-32-111
-rw-rw-r--. 1 root    root    5801123 Apr 10 13:16 ip-10-152-32-111.tar.gz
drwxr-xr-x. 2 root    root         60 Apr 10 13:16 ip-10-152-12-22
-rw-rw-r--. 1 root    root    1604685 Apr 10 13:16 ip-10-152-12-22.tar.gz
drwxr-xr-x. 2 root    root         60 Apr 10 13:16 ip-10-152-44-66
-rw-rw-r--. 1 root    root     996041 Apr 10 13:16 ip-10-152-44-66.tar.gz

``` 
 
## Restore log level
 
```
ansible-playbook -i inventory playbooks/master-log/config.yaml -t loglevel -e debug_loglevel=2
```
