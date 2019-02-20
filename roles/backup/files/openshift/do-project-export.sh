#!/bin/bash

mkdir -p $1

# get all projects
oc get projects --no-headers | awk '{print $1}' > $1/allprojects.txt
lines=`cat $1/allprojects.txt`

cd $1

for project in $lines ; do
        /backup/openshift/project_export.sh $project
done
