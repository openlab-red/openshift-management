# OpenShift Quota

|Playbooks                 |
|--------------------------|
|openshift-quota/config.yml|

Quota Tiers

| Profile         | Project CPU               | Project Memory         | Per Pod CPU                                     | Per Pod Memory                                    |
|-----------------|---------------------------|------------------------|------------------------------------------------ |---------------------------------------------------|
| X-Small         | 1 core (burstable to 2)   | 2Gi (burstable to 4)   | 10m - 1000m; default request/limit: 50m/250m    | 128 Mi - 1Gi; default request/limit: 256Mi/256Mi  |
| Small (default) | 2 core (burstable to 4)   | 4Gi (burstable to 8)   | 10m - 1000m; default request/limit: 50m/500m    | 128 Mi - 2Gi; default request/limit: 256Mi/512Mi  |
| Medium          | 4 core (burstable to 6)   | 8Gi (burstable to 12)  | 20m - 2000m; default request/limit: 50m/1000m   | 128 Mi - 4Gi; default request/limit: 256Mi/1Gi    |
| Large           | 6 core (burstable to 8)   | 12Gi (burstable to 16) | 20m - 2000m; default request/limit: 100m/2000m  | 256 Mi - 6Gi; default request/limit: 512Mi/2Gi    |
| X-Large         | 12 core (burstable to 16) | 32Gi (burstable to 66) | 20m - 6000m; default request/limit: 100m/4000m  | 256 Mi - 16Gi; default request/limit: 512Mi/8Gi   |


* Ansible **openshift_quota_tier** possible values:
  * xsmall
  * small
  * medium
  * large
  * xlarge

>
> Default tier quota is small
> **openshift_quota_tier=small**
>

1. Apply Quota for multiple project

    ```
      ansible-playbook playbooks/openshift-quota/config.yml -e '{"openshift_quota_projects": ["myproject", "myproject-2"]}'
    ```
    
    Use a different tier:
    
    ```
      ansible-playbook playbooks/openshift-quota/config.yml -e '{"openshift_quota_projects": ["myproject", "myproject-2"]}' -e openshift_quota_tier=medium
    ```

2. Apply Quota for all projects

    ```
      ansible-playbook playbooks/openshift-quota/config.yml -e openshift_quota_all_projects=true
    ```

    **openshift_quota_all_projects** excludes the infrastructure projects:
    - default
    - kube-system
    - openshift-infra
    - openshift-metrics
    - openshift-grafana
    - grafana
    - openshift-service-catalog
    - openshift-glusterfs
    - glusterfs
    - storage
    - openshift-web-console
    - kube-service-catalog
    - kube-public
    - logging
    - management-infra
    - openshift-node
    - openshift-template-service-broker
    - openshift-ansible-service-broker
    - openshift-management
    - openshift

    To exclude additional projects use **openshift_quota_projects_excluder** as extra var
    
    ```
    ansible-playbook -i playbooks/openshift-quota/config.yml -e openshift_quota_all_projects=true -e '{"openshift_quota_projects_excluder": ["customer-infra", "customer-broker"]}'
    ```

3. View Current quota

    ```
     oc get quota,limitrange --all-namespaces --show-labels
    ```