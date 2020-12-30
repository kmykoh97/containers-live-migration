#!/bin/bash

export ROOTDIR="$PWD"

# Infrastructure set up and management
cd $ROOTDIR/manager/config

## security keys
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa

## start terraform
terraform init
terraform apply
terraform output ansible_inventory > hosts
sleep 2s

## parse ansible inventory file
firsthostip="$(echo `ansible host -i hosts --list-hosts | tail -n +2 | sed -n '1 p'`)"
secondhostip="$(echo `ansible host -i hosts --list-hosts | tail -n +2 | sed -n '2 p'`)"
echo $firsthostip
echo $secondhostip
sleep 32s # wait for instances boot

# Install development tools
cd $ROOTDIR/dev-tool-install/config
cp $ROOTDIR/manager/config/hosts ./hosts

## test ping for all vm
ansible -i hosts -m ping all
sleep 5s

## run
ansible-playbook -i hosts playbook.yaml
sleep 12s

# Setting up VPN secure tunnel
cd $ROOTDIR/tunnel/config
cp $ROOTDIR/manager/config/hosts ./hosts

## run
ansible-playbook -i hosts playbook.yaml
sleep 17s

# Install migration tools
cd $ROOTDIR/migrate-tool-install/config
cp $ROOTDIR/manager/config/hosts ./hosts

## run
ansible-playbook -i hosts -e source=${firsthostip} -e target=${secondhostip} playbook.yaml
sleep 15s

# Setting up containers
cd $ROOTDIR/container/config
cp $ROOTDIR/manager/config/hosts ./hosts

## run
ansible-playbook -i hosts -e source=${firsthostip} playbook.yaml
sleep 20s

# after this script, http://$firsthostip:80 would be the wordpress application