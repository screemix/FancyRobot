FROM ros:noetic-ros-base-focal

# Update and install of ros
RUN apt-get update && apt-get install -y \
    ros-noetic-ros-base

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    ros-noetic-geographic-info \
    ros-noetic-pcl-ros \
    ros-noetic-opencv-apps \
    ros-noetic-image-geometry \
    ros-noetic-tf2-geometry-msgs \
    ros-noetic-tf2-sensor-msgs \
    ros-noetic-angles

ARG USER=docker_raai_user
ARG UID=1000
ARG GID=1000
# default password
ARG PW=user 

RUN useradd -m ${USER} --uid=${UID} && echo "${USER}:${PW}" | chpasswd && adduser ${USER} sudo
RUN apt-get update && apt-get install -y \
    mc \
    libeigen3-dev \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Install OMPL
WORKDIR /home/${USER}
RUN cd /home/${USER}
RUN curl https://ompl.kavrakilab.org/install-ompl-ubuntu.sh > /home/${USER}/install-ompl-ubuntu.sh && \
    chmod u+x /home/${USER}/install-ompl-ubuntu.sh && \
    /home/${USER}/install-ompl-ubuntu.sh
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib

WORKDIR /home/${USER}
RUN cd /home/${USER} && mkdir -p catkin_ws/src && chown -R ${UID}:${GID} ./

USER ${UID}:${GID}
