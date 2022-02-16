#!/bin/bash

# called from cron @reboot using field's user crontab
# inspired by: https://answers.ros.org/question/140426/issues-launching-ros-on-startup/

DAY=$(date "+%Y-%m-%d")
NOW=$(date "+%Y-%m-%dT%H.%M.%S.%N")
LOGDIR="/home/field/project11/log/${DAY}"
mkdir -p "$LOGDIR"
LOG_FILE="${LOGDIR}/autostart_${NOW}.txt"

{

echo ""
echo "#############################################"
echo "Running autostart_mystique.bash"
date
echo "#############################################"
echo ""
echo "Logs:"

source /opt/ros/noetic/setup.bash
source /home/field/project11/catkin_ws/devel/setup.bash

set -v

export ROS_WORKSPACE=/home/field/project11/catkin_ws
export ROS_IP=192.168.100.112

#wait for mystique to be pingable by self
while ! ping -c 1 -W 1 mystique; do
    echo "Waiting for ping to mystique..."
    sleep 1
done

echo "Wait 10 seconds before launching ROS..."
sleep 10


/usr/bin/tmux new -d -s project11 roscore
/usr/bin/tmux splitw -p 90
/usr/bin/tmux send-keys "rosrun rosmon rosmon --name=rosmon_ben_mystique ben_hardware mystique.launch logDirectory:=${LOGDIR} operator_ip:=192.168.100.142" C-m

} >> "${LOG_FILE}" 2>&1
