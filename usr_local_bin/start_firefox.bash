#!/bin/bash

export Xauthority="/var/run/lightdm/root:0"
export DISPLAY=":0"
nohup firefox > /dev/null 2>&1 &
