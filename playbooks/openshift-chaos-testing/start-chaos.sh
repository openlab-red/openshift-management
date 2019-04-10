#! /bin/bash

LIMIT_GROUPS=( nodes masters nodes:!masters )
TASK=( "crash_node" "crash_etcd_leader" )

while true;
do
tsize=${#TASK[@]}
tindex=$(($RANDOM % $tsize))

lsize=${#TASK[@]}
lindex=$(($RANDOM % $tsize))


echo "executing: ansible-playbook -i inventory/hosts testing.yaml -l '${LIMIT_GROUPS[$lindex]}' -t ${TASK[$tindex]}"
sleep $[ ( $RANDOM % 10 )  + 1 ]s
done