# Install and set up tools needed for migration

We would need additional tools such as RSync, NFS, CRIU and more for migration to work.

## Inventory

Copy host file from the output of manager section:

```sh
cp ../manager/config/hosts ./config/hosts
```

## Provisioning

```sh
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa

# start running Ansible script, -e to provide additional parameters
cd config
ansible-playbook -i hosts -e source=8.9.10.11 -e target=104.215.155.205 playbook.yaml
```
