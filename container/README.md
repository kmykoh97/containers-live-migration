# Prepare container in OCI format

We would pull images from docker archive, then convert them into OCI equavalent format

- Skopeo: used to convert each image into an Open Containers Initiative (OCI) compliant image.
- umoci: extract image into an OCI bundle.

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
