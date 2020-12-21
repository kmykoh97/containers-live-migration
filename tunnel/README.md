# Set up IPSec tunnel using StrongSwan

2 hosts will be set up and then communicate through IPSec tunnel during migration for security. This is a testing synergy. NFS, Rsync over normal tcp can also be used to achieve the same result(without security).

## Inventory

Copy host file from the output of manager section:

```sh
cp ../manager/config/hosts ./config/hosts
```

## Provisioning

```sh
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa

# start running Ansible script
cd config
ansible-playbook -i hosts playbook.yaml
```

## Reference

- https://networklore.com/ansible-getting-started/
- https://github.com/torian/ansible-role-strongswan
- https://docs.ansible.com/ansible/latest/collections/community/general/pam_limits_module.html