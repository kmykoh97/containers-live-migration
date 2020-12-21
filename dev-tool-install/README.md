# Installing development tools for Ansible

For Ansible to work at full capacity. Python needs to be installed on every instance.

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

## Ping

```sh
ansible -i hosts -m ping all
```