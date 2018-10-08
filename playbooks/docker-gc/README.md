# Docker GC

Garbage collection playbooks **_docker-gc/config.yml_**.

Containers that exited more than an hour ago are removed.

Optionally, remove volumes that are not associated to any remaining container after removal (Available only for docker >= 1.9.0

|Tags                       | Tasks                                                                            |
|---------------------------|----------------------------------------------------------------------------------|
|docker_gc_containers       | Containers that are in exited status and dead                                    |
|docker_gc_images           | Images in dangling stats and that don't belong to any remaining container.       |  
|docker_gc_volumes          | Remove volumes that are not associated to any remaining container after removal  |     

## Dry Run

Performing a dry-run instead of the prune

|Parameters                 | Default |
|---------------------------|---------| 
| openshift_prune_dryrun    | False   |

## GC Containers

```
ansible-playbook docker-gc/config.yml -t docker_gc_containers
```

## GC Images

```
ansible-playbook docker-gc/config.yml -t docker_gc_images
```

## GC Volumes

```
ansible-playbook docker-gc/config.yml -t docker_gc_volumes
```
