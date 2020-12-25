#!/bin/bash

export ROOTDIR="$PWD"

# Finishing touches
cd $ROOTDIR/clean-up/config
cp $ROOTDIR/manager/config/hosts ./hosts

## parse ansible inventory file
firsthostip="$(echo `ansible host -i hosts --list-hosts | tail -n +2 | sed -n '1 p'`)"
secondhostip="$(echo `ansible host -i hosts --list-hosts | tail -n +2 | sed -n '2 p'`)"
echo $firsthostip
echo $secondhostip

## run
ansible-playbook -i hosts -e source=${firsthostip} playbook.yaml
sleep 10s

# Setting up containers
cd $ROOTDIR/container/config
cp $ROOTDIR/manager/config/hosts ./hosts

## run
ansible-playbook -i hosts -e source=${firsthostip} playbook.yaml
sleep 20s

# after this script, http://$firsthostip:80 would be the wordpress application

# Destroy everything
# cd $ROOTDIR/manager/config
# terraform destroy # uncomment to run this after perf test