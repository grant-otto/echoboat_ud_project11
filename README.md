[![docker-noetic-ros-base](../../actions/workflows/ros-base-docker.yml/badge.svg)](../../actions/workflows/ros-base-docker.yml)

# Project11: UD Echoboat Integration

The Project 11 framework was developed as a backseat driver for Autonomous Surface Vehicles
(ASVs). Key design features include the ability to quickly and easily specify survey plans; monitoring of mission progress, even
over unreliable wireless networks; and to provide an environment to develop advanced autonomous technologies.

## Installation
Ubuntu only. Currently, the vehicle is installed to a Jetson Nano (regular, NOT the 2GB version), and the operator is installed to a Panasonic Toughbook booted with Ubuntu. If you buy a new Jetson nano, do not use the stock .iso provided by NVIDIA; use the one found [here](https://qengineering.eu/install-ubuntu-20.04-on-jetson-nano.html). This installs a custom Ubuntu 20.04 image made for Jetsons (not yet supported by NVIDIA as of 3/10/22). If you get an error related to vulcan, open a terminal and run the following:

    sudo rm -r /usr/share/vulkan/icd.d

### Vehicle Machine Installation Guide

Install ROS Noetic using the standard ROS install workflow on the ROS Wiki. From there, you can quickly install and run Project11 with the following:

Create project11 workspace and clone

    mkdir -p project11/catkin_ws/src
    cd project11/catkin_ws/src
    git clone https://github.com/CCOMJHC/project11.git
    git clone https://github.com/grant-otto/echoboat_ud_project11.git

Update and install necessary packages with apt-get and rosdep

    sudo apt-get update
    sudo apt-get install python3-rosdep python3-vcstool python3-catkin-tools
    sudo rosdep init
    rosdep update
    wget https://raw.githubusercontent.com/mavlink/mavros/master/mavros/scripts/install_geographiclib_datasets.sh
    sudo bash ./install_geographiclib_datasets.sh

Import stock sim_demo github repos and additional echoboat-related repos

    vcs import < project11/config/repos/sim_demo.repos
    vcs import < echoboat_ud_project11/config/echoboat_ud.repos
    
    rosdep install --from-paths . --ignore-src -r -y

    cd ..
    catkin build

Set up start-on-boot using crontab and tmux. The device will now run the launch file on boot in a tmux terminal.

    sudo apt install tmux cron
    crontab -l > mycron
    chmod +x ~/project11/catkin_ws/src/echoboat_ud_project11/scripts/autostart_echoboatud.bash
    echo "@reboot /home/jetson/project11/catkin_ws/src/echoboat_ud_project11/scripts/autostart_echoboatud.bash" >> mycron
    crontab mycron
    rm mycron
    
You will likely need to run the below command to enable permissions for the Pixhawk via USB. This will need a reboot to take effect. You can do it later or now if you want to test the launch file.

    sudo usermod -a -G dialout $USER
    
Now, Project11 (headless robot) will launch on boot. To access the tmux terminal, open a normal terminal and run:

    tmux attach-session -t project11

If this doesn't work, verify that the session is running using:

    tmux ls

### Operator Machine Installation Guide

Install ROS Noetic using the standard ROS install workflow on the ROS Wiki. From there, you can quickly install and run Project11 with the following:

    mkdir -p project11/catkin_ws/src
    cd project11/catkin_ws/src
    git clone https://github.com/CCOMJHC/project11.git
    git clone https://github.com/grant-otto/echoboat_ud_project11.git

    sudo apt-get update
    sudo apt-get install python3-rosdep python3-vcstool python3-catkin-tools
    sudo rosdep init
    rosdep update

    vcs import < project11/config/repos/sim_demo.repos
    
    rosdep install --from-paths . --ignore-src -r -y

    cd ..
    catkin build
    
Create CAMP_STARTUP directory on the Desktop and add the camp executable
    
    mkdir ~/Desktop/CAMP_STARTUP
    cp ~/project11/catkin_ws/src/echoboat_ud_project11/scripts/start_camp.bash ~/Desktop/CAMP_STARTUP
    cd ~/Desktop/CAMP_STARTUP
    chmod +x start_camp.bash

To launch the UI, run the start_camp.bash file under ~/Desktop/CAMP_STARTUP. You can open a terminal and run:

    cd ~/Desktop/CAMP_STARTUP
    ./start_camp.bash

Or, configure your gnome settings so that you can double click the file and run in terminal. 

## More Information

For more info on Project11 including simulation etc., see the CCOM/JHC project11 repo located [here](https://github.com/CCOMJHC/project11).

Acknowledgements go to Roland Arsenault and Val Schmidt (CCOM) and Marcos Berrera (Seafloor Systems) for helping with the integration.
