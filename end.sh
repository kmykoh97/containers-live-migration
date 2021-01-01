#!/bin/bash

export ROOTDIR="$PWD"

# Infrastructure tear down
cd $ROOTDIR/manager/config
terraform destroy