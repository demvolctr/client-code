#!/bin/bash
#  
#  refresh_display.bash: press the left mouse button to refresh the display
#
#      Jon Hull -- 11/1/16
#      usage: when logged in as demcaller: ./refresh_display.bash
#
export Xauthority="/var/run/lightdm/root:0"
export DISPLAY=":0"
xdotool key space
