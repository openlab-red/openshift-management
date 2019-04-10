# Chaos testing with openshift infra
To be able to kill openshift infrastructure compoents randomly.

## Usage

### Kill one openshift node randomly
```
ansible-playbook -i inventory/hosts openshift-chaos-testing/config.yaml -l 'nodes:!masters' -t crash_node
```

### Kill openshift master or etcd randomly
```
ansible-playbook -i inventory/hosts openshift-chaos-testing/config.yaml -l 'masters' -t crash_node
```

### Kill openshift etcd leader
```
ansible-playbook -i inventory/hosts openshift-chaos-testing/config.yaml -l 'masters' -t crash_etcd_leader
```
