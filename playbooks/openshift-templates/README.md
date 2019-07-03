# OpenShift Templates

Manage your OpenShift templates.

## Tested on

| OpenShift Version   |
|---------------------|
|       3.10          |
|                     |
|       3.11          |

## Extra Vars
|    Extra Vars          |  Description                                          |  Default  |
|------------------------|-------------------------------------------------------|-----------|
| -e @templates_file.yaml|  Delete specifed templates using a file.             |  NA |


## Usage

### Restore All

```
ansible-playbook -i inventory playbooks/openshift-templates/config.yaml --tags backup
```

### Delete specifed templates using a file
```
ansible-playbook -i inventory playbooks/openshift-templates/config.yaml --tags delete -e "@templates.yaml"
```

### Example template file
```
---
templates:
  - apicurito
  - 3scale-gateway
```
