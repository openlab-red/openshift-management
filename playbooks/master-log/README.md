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
ansible-playbook -i inventory playbooks/master-log/config.yaml -t collect
``` 

Logs are saved under /tmp/master-logs/ of your ansible host, for each master `<hostname>.tar.gz`.
It contains OpenShift Master API, Controllers  and ETCD logs.

 
## Restore log level
 
```
ansible-playbook -i inventory playbooks/master-log/config.yaml -t loglevel -e debug_loglevel=2
```