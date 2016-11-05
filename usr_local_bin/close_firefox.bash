#!/bin/bash
#
#  close_firefox.bash: gracefully close firefox from the command line
#
#     usage:  login as demcaller, then ./close_firefox.bash
#
#     Jon Hull -- 10/31/16
#

export Xauthority="/var/run/lightdm/root:0"
export DISPLAY=":0"
wmctrl -c "Mozilla Firefox" 
sleep 1
wmctrl -l | grep "Confirm close" > /dev/null
xdotool search --name "Confirm close" key Return
exit 0
