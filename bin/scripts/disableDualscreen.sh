#!/bin/bash
 
PID=$(ps ax | grep Xorg | grep :8 | grep -v grep | awk '{print $1}')
 
# Kill the second X server.
if [ ! -z $PID ]; then
   sudo kill -15 $PID
fi
 
# Now you need to turn off nvidia card completely.
if lsmod | grep -q nvidia; then
  sudo rmmod nvidia
fi
sudo tee /proc/acpi/bbswitch <<<OFF
sudo systemctl restart bumblebeed
xrandr --output VIRTUAL8 --off
