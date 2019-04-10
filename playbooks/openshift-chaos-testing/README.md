# Chaos testing with openshift infra
To be able to kill openshift infrastructure compoents randomly.

## Usage
Start the test by running 
```
./start-chaos.sh <absolute-path-to-inventroy>
```

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
