# Docker Auth

Setup docker auth config file on OpenShift Node.


## Parameters

|Parameters                 | Default |  Descriptions            |
|---------------------------|---------| ------------------------ |
| docker_auth_registries    | []      |  List of auth registries |



## Example

```yml

docker_auth_registries:
- name: redhat.io
  auth: <token>
- name: https://index.docker.io/v1/
  auth: <token>
```

## Launch

```
ansible-playbook  docker-auth/config.yml
```
