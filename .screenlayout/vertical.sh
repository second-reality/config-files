#!/bin/sh
if [ -f /.laptop ]
then
    xrandr\
    --output LVDS-1 --mode 1366x768 --pos 0x0 --rotate left 
else
    xrandr\
    --output HDMI2 --off\
    --output HDMI1 --off\
    --output DP3 --mode 1920x1080 --pos 0x0 --rotate left\
    --output DP2 --off\
    --output DP1 --off
fi
