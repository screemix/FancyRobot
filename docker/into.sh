#!/bin/bash

docker exec --user "docker_raai_user" -it planning_with_thunder \
    /bin/bash -c ". /ros_entrypoint.sh; cd /home/docker_raai_user; /bin/bash"