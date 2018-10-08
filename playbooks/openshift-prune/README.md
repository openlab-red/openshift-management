# OpenShift Prune


As an administrator, you can periodically prune older versions of objects from your OpenShift Container Platform instance that are no longer needed.

The **_openshift-prune/config.yml_** playbook runs the openshift prune command for builds, deployments and images.

|Tags                       |
|---------------------------|
|openshift_prune_builds     |
|openshift_prune_deployments|
|openshift_prune_images     |

Without specifying any tags, it execs all the prune types.

## Dry Run

Performing a dry-run instead of the prune

|Parameters                 | Default |
|---------------------------|---------| 
| openshift_prune_dryrun    | False   |

```
ansible-playbook openshift-prune/config.yml -e openshift_prune_dryrun=true
```

## Prune Images

In order to prune images that are no longer required by the system due to age, status, or exceed limits.

|Parameters                            | Default |
|--------------------------------------|---------| 
| openshift_prune_images_token         | ""      |
| openshift_prune_images_tag_revisions | 3       |
| openshift_prune_images_keep_younger  | 60m     |

```
 ansible-playbook -i inventory/dev playbooks/openshift-prune.yml -e openshift_prune_images=true
```

## Prune deployments

In order to prune deployments that are no longer required by the system due to age and status.

|Parameters                            | Default |
|--------------------------------------|---------| 
| openshift_prune_complete             | 5       |
| openshift_prune_failed               | 1       |
| openshift_prune_keep_younger         | 60m     |

```
 ansible-playbook -i inventory/dev playbooks/openshift-prune.yml -e openshift_prune_deployments=true
```

## Prune builds

In order to prune builds that are no longer required by the system due to age and status.

|Parameters                            | Default |
|--------------------------------------|---------| 
| openshift_prune_complete             | 5       |
| openshift_prune_failed               | 1       |
| openshift_prune_keep_younger         | 60m     |

```
 ansible-playbook -i inventory/dev playbooks/openshift-prune.yml -e openshift_prune_builds=true
```
