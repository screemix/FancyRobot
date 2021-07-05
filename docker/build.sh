#!/bin/bash

green=`tput setaf 2`
reset_color=`tput sgr0`

whitelist="--only-pkg-with-deps occupancy_grid"
tag="latest"

main () {
    cd "$(dirname "$0")";
    image_build;
}

image_build () {
    echo ${green}"Building image from Dockerfile: "${reset_color};    
    docker build -f ./Dockerfile . -t registry.gitlab.com/raai_planning_workshop/planning_with_thunder:latest;
}

main "$@"; exit