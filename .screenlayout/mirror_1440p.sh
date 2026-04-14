#!/bin/sh
xrandr --output HDMI-A-0 --primary --mode 2560x1440 --pos 0x0 --rotate normal --output DisplayPort-0 --off --output DisplayPort-1 --off --output DisplayPort-2 --off
sleep 1
hsetroot -solid '#dddddd'
