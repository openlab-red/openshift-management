# OpenShift Master Identity Providers


This repository contains all necessary playbooks to install Identity Providers in OpenShift Container Platform as post installation step.

1. Fill all the necessary variables with the correct value **inventory/group_vars/OSEv3/main.yaml**

2. Launch **openshift-identity-providers/config.yaml**
   
   ```
     ansible-playbook playbooks/openshift-identity-providers/config.yaml
   ```
