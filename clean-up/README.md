# Cleaning Up

This is done after successful migration. In this step, we assume that the dns server has been configured to point to new target address and all routing cache has been flushed. If otherwise, we would hold this step.

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
ansible-playbook -i hosts -e source=8.9.10.11 playbook.yaml
```
