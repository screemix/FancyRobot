#!/bin/bash

green=`tput setaf 2`
reset_color=`tput sgr0`

whitelist="--only-pkg-with-deps occupancy_grid"
tag="latest"

main () {
    cd "$(dirname "$0")";
    image_build;
}

tag=registry.gitlab.com/raai_planning_workshop/planning_with_thunder:latest

if [ ! -z "$1" ]
  then
    tag=$1
fi


image_build () {
    echo ${green}"Building image from Dockerfile with tag: ${tag}"${reset_color};    
    docker build -f ./Dockerfile . -t $tag;
}

main "$@"; exit