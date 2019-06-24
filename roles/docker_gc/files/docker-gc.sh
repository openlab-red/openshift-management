#!/bin/bash

EXEC="$1"
TYPE=$2
MKTEMP=$(dirname $(realpath $0))

function containers {
    case $1 in
        --check)
            exited=$(docker ps -qa --filter status=exited --filter status=dead)
            inspect $exited
            ;;
        --run)
            exited=$(docker ps -qa --filter status=exited --filter status=dead)
            to_remove=$(inspect $exited)
            docker rm -v -f $to_remove
            ;;
    esac
}

function inspect {
  for container in ${1}
    do
      label=$(docker inspect $container -f '{{index .Config.Labels "io.kubernetes.pod.name"}}')
      return_running ${label}
      getval=$(return_running ${label})
    done
  echo ${getval}
}

function return_running {
    running_containers_by_label=$(docker ps -q --filter status=running --filter "label=io.kubernetes.pod.name=${1}")
    for container in $running_containers_by_label
    do
        running_list+=" $(docker inspect $container -f '{{.Id}}') "
    done
    echo $running_list
}

function images {
    case $1 in
        --check)
            docker images --no-trunc -q --filter dangling=true | sort | uniq > ${MKTEMP}/images.dangling
            docker inspect $(docker ps -q) -f "{{.Image}}" | sort | uniq > ${MKTEMP}/images.used
            comm -23 ${MKTEMP}/images.dangling ${MKTEMP}/images.used | tee ${MKTEMP}/images.gc
            ;;
        --run)
            xargs -n 1 docker rmi -f < ${MKTEMP}/images.gc
            ;;
    esac
}

function volumes {
    case $1 in
        --check)
            docker volume ls -qf dangling=true
            ;;
        --run)
            docker volume rm $(docker volume ls -qf dangling=true)
            ;;
    esac
}

case ${TYPE} in
    containers|images|volumes)
        ${TYPE} ${EXEC}
        ;;
    *)
        echo $"Usage: $0 {containers|images|volumes}"
        exit 1
        ;;
esac
