#!/bin/bash

EXEC="$1"
TYPE=$2
MKTEMP=$(dirname $(realpath $0))

function containers {
    case $1 in
        --check)
            docker ps -qa --filter status=exited --filter status=dead
            ;;
        --run)
            docker rm -v $(docker ps -qa --filter status=exited --filter status=dead)
            ;;
    esac
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

