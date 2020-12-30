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

# Destroy everything
# cd $ROOTDIR/manager/config
# terraform destroy # uncomment to run this after perf test