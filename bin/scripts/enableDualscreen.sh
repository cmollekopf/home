#!/bin/sh

sudo modprobe bbswitch
sudo systemctl restart bumblebeed
sudo tee /proc/acpi/bbswitch <<<ON
optirun true
intel-virtual-output

# xrandr --output VIRTUAL8

#office
# xrandr --output VIRTUAL3 --off --output VIRTUAL2 --off --output VIRTUAL1 --off --output VIRTUAL7 --off --output VIRTUAL6 --mode VIRTUAL6.642-2560x1440 --pos 1600x0 --rotate normal --output VIRTUAL5 --off --output VIRTUAL4 --off --output VIRTUAL9 --off --output VIRTUAL8 --off --output LVDS1 --mode 1600x900 --pos 0x0 --rotate normal --output VGA1 --off
# xrandr --output VIRTUAL3 --off --output VIRTUAL2 --off --output VIRTUAL1 --off --output VIRTUAL7 --off --output VIRTUAL8 --mode VIRTUAL8.668-2560x1440 --pos 1600x0 --rotate normal --output VIRTUAL5 --off --output VIRTUAL4 --off --output VIRTUAL9 --off --output VIRTUAL6 --off --output LVDS1 --mode 1600x900 --pos 0x0 --rotate normal --output VGA1 --off
xrandr --output VIRTUAL3 --off --output VIRTUAL2 --off --output VIRTUAL1 --off --output VIRTUAL7 --off --output VIRTUAL8 --mode VIRTUAL8.644-2560x1440 --pos 1600x0 --rotate normal --output VIRTUAL5 --off --output VIRTUAL4 --off --output VIRTUAL9 --off --output VIRTUAL6 --off --output LVDS1 --mode 1600x900 --pos 0x0 --rotate normal --output VGA1 --off

#home
# xrandr --output VIRTUAL3 --off --output VIRTUAL2 --off --output VIRTUAL1 --off --output VIRTUAL7 --off --output VIRTUAL6 --mode VIRTUAL6.665-2560x1440 --pos 1600x0 --rotate normal --output VIRTUAL5 --off --output VIRTUAL4 --off --output VIRTUAL9 --off --output VIRTUAL8 --off --output LVDS1 --mode 1600x900 --pos 0x0 --rotate normal --output VGA1 --off
