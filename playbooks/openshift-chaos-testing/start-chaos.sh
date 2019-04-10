#!/bin/bash

LIMIT_GROUPS=( nodes masters nodes:!masters )
TASK=( crash_node crash_etcd_leader )

while true
do
tsize=${#TASK[@]}
tindex=$(($RANDOM % $tsize))

lsize=${#LIMIT_GROUPS[@]}
lindex=$(($RANDOM % $lsize))

sleep_min=30
sleep_range=30
sleep_time=$[ ( $RANDOM % $sleep_range )  + $sleep_min ]

echo "executing: ansible-playbook -i inventory/hosts testing.yaml -l '${LIMIT_GROUPS[$lindex]}' -t ${TASK[$tindex]}"

echo "sleeping $sleep_time minutes"

sleep "$sleep_time"m
done