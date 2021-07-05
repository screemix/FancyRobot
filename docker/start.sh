#!/bin/bash

cd "$(dirname "$0")";
cd ..
root_dir=$PWD
cd launch
launch_dir=$PWD
# path to folder with source code by default

if [ ! -d "$root_dir/workspace/src" ]
then
    mkdir -p workspace/src
fi

cd $root_dir/workspace/src
workspace_dir=$PWD


if [ "$(docker ps -aq -f status=exited -f name=planning_with_thunder)" ]; then
    docker rm planning_with_thunder;
fi

tag="latest"
image="registry.gitlab.com/raai_planning_workshop/planning_with_thunder"

docker run -it -d --rm \
    --env="DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    --privileged \
    --name planning_with_thunder \
    --net "host" \
    -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
    -v $workspace_dir/:/home/docker_raai_user/catkin_ws/src/:rw \
    -v $launch_dir/:/home/docker_raai_user/launch/:rw \
    $image:$tag
