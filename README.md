[![docker-noetic-ros-base](../../actions/workflows/ros-base-docker.yml/badge.svg)](../../actions/workflows/ros-base-docker.yml)

# Project11: A mapping focused open-sourced software framework for Autonomous Surface Vehicles

The Project 11 framework was developed as a backseat driver for Autonomous Surface Vehicles
(ASVs). Key design features include the ability to quickly and easily specify survey plans; monitoring of mission progress, even
over unreliable wireless networks; and to provide an environment to develop advanced autonomous technologies.

## Installation
Ubuntu only. Currently, the vehicle is installed to a Jetson Nano (regular, NOT the 2GB version), and the operator is installed to a Panasonic Toughbook booted with Ubuntu. If you buy a new Jetson nano, do not use the stock .iso provided by NVIDIA; use the one found [here](https://qengineering.eu/install-ubuntu-20.04-on-jetson-nano.html). This installs a custom Ubuntu 20.04 image made for Jetsons (not yet supported by NVIDIA as of 3/10/22).

### Vehicle Machine Installation Guide

Install ROS Noetic using the standard ROS install workflow on the ROS Wiki. From there, you can quickly install and run Project11 with the following:

    mkdir -p project11/catkin_ws/src
    cd project11/catkin_ws/src
    git clone https://github.com/CCOMJHC/project11.git
    git clone https://github.com/grant-otto/echoboat_ud_project11.git

    sudo apt-get install python3-rosdep python3-vcstool
    sudo rosdep init
    rosdep update

    vcs import < echoboat_ud_project11/config/mystique.repos
    vcs import < echoboat_ud_project11/config/echoboat_ud.repos
    
    rosdep install --from-paths . --ignore-src -r -y

    cd ..
    catkin_make

TODO: add crontab

    source devel/setup.bash
    roslaunch echoboat_ud_project11 echo_robot.launch
    
Now, Project11 (headless robot) will launch on boot.

### Operator Machine Installation Guide

Install ROS Noetic using the standard ROS install workflow on the ROS Wiki. From there, you can quickly install and run Project11 with the following:

    mkdir -p project11/catkin_ws/src
    cd project11/catkin_ws/src
    git clone https://github.com/CCOMJHC/project11.git
    git clone https://github.com/grant-otto/echoboat_ud_project11.git

    sudo apt-get install python3-rosdep python3-vcstool
    sudo rosdep init
    rosdep update

    vcs import < project11/config/repos/sim_demo.repos
    
    rosdep install --from-paths . --ignore-src -r -y

    cd ..
    catkin_make

TODO: add crontab

    source devel/setup.bash
    roslaunch echoboat_ud_project11 operator_echo.launch

From here on out, the last command will launch the UI.

## More Information

For more info on Project11 including simulation etc., see the CCOM/JHC project11 repo located [here](https://github.com/CCOMJHC/project11).

Acknowledgements go to Roland Arsenault and Val Schmidt (CCOM) and Marcos Berrera (Seafloor Systems) for helping with the integration.
