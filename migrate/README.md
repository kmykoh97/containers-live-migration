# Starting migration

Here, we will begin live migration. We would execute migration scripts for different purposes. Rsync is used for migration in secure tunnel.

After migration, in actual production deployments DNS propagation takes time. Ie, some clients may still access the application at the source site. To handle these new incoming connections, we keep HAProxy and the VPN running. HAProxy will automatically use the target host as a new backend once it has detected that the target is up. Source host can only be taken down once all routing cache has been flushed with new domain.

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
