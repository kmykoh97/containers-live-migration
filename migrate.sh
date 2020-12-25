#!/bin/bash

export ROOTDIR="$PWD"

# Begin migration
cd $ROOTDIR/migrate/config
cp $ROOTDIR/manager/config/hosts ./hosts

## parse ansible inventory file
firsthostip="$(echo `ansible host -i hosts --list-hosts | tail -n +2 | sed -n '1 p'`)"
secondhostip="$(echo `ansible host -i hosts --list-hosts | tail -n +2 | sed -n '2 p'`)"
echo $firsthostip
echo $secondhostip

## run
ansible-playbook -i hosts -e source=${firsthostip} -e target=${secondhostip} -e precopy=true playbook.yaml
sleep 15s

