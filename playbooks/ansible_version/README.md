# Ansible switch version

These playbooks "could" run together if there are not breaking changes on ansible code.
To avoid any undesired problem, run separately.


## Upgrade Ansible

```


ansible-playbook -i hosts upgrade-ansible.yaml

TASK [Gather current Ansible version] 
ok: [localhost] => {
    "msg": "ansible-2.4.6.0-1.el7ae.noarch"
}


[root@localhost ~]# ansible --version
ansible 2.7.8
  config file = /etc/ansible/ansible.cfg
  configured module search path = [u'/root/.ansible/plugins/modules', u'/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/lib/python2.7/site-packages/ansible
  executable location = /bin/ansible
  python version = 2.7.5 (default, Sep 12 2018, 05:31:16) [GCC 4.8.5 20150623 (Red Hat 4.8.5-36)]

```

## Downgrade Ansible

```
ansible-playbook -i hosts downgrade-ansible.yaml -e ansible_rpm_version=ansible-2.4.6.0-1.el7ae.noarch

[root@localhost ~]# ansible --version
ansible 2.4.6.0
  config file = /etc/ansible/ansible.cfg
  configured module search path = [u'/root/.ansible/plugins/modules', u'/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/lib/python2.7/site-packages/ansible
  executable location = /bin/ansible
  python version = 2.7.5 (default, Sep 12 2018, 05:31:16) [GCC 4.8.5 20150623 (Red Hat 4.8.5-36)]
```

