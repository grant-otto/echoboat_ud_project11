#!/bin/bash

# called from cron @reboot using field's user crontab
# inspired by: https://answers.ros.org/question/140426/issues-launching-ros-on-startup/

DAY=$(date "+%Y-%m-%d")
NOW=$(date "+%Y-%m-%dT%H.%M.%S.%N")
LOGDIR="/home/jetson/project11/log/${DAY}"
mkdir -p "$LOGDIR"
LOG_FILE="${LOGDIR}/autostart_${NOW}.txt"

{

echo ""
echo "#############################################"
echo "Running autostart_echoboatud.bash"
date
echo "#############################################"
echo ""
echo "Logs:"

source /opt/ros/noetic/setup.bash
source /home/jetson/project11/catkin_ws/devel/setup.bash

set -v

export ROS_WORKSPACE=/home/jetson/project11/catkin_ws
#export ROS_IP=192.168.100.112

echo "Wait 10 seconds before launching ROS..."
sleep 10

/usr/bin/tmux new -d -s project11 roscore
/usr/bin/tmux splitw -p 90
/usr/bin/tmux send-keys "roslaunch echoboat_ud_project11 echo_robot.launch" C-m

} >> "${LOG_FILE}" 2>&1
