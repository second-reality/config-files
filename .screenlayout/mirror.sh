#!/bin/sh
xrandr --output eDP-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output HDMI-1 --mode 1920x1080 --pos 0x0 --rotate normal --output DP-2 --off --output HDMI-2 --off --output DP-1 --mode 1920x1080 --pos 0x0 --rotate normal --output HDMI-3 --off
xrandr --output HDMI-1 --set "Broadcast RGB" "Full"
xrandr --output DP-1 --set "Broadcast RGB" "Full"
xset s off
xset -dpms
