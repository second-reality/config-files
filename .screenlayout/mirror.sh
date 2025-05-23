#!/bin/sh
# set DP-1 and DP-2 because input name get switched sometimes
xrandr --output eDP-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output HDMI-1 --off --output DP-2 --mode 1920x1080 --pos 0x0 --rotate normal --output HDMI-2 --off --output DP-1 --off --output HDMI-3 --off ||
xrandr --output eDP-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output HDMI-1 --off --output DP-2 --off --output HDMI-2 --off --output DP-1 --mode 1920x1080 --pos 0x0 --rotate normal --output HDMI-3 --off
xrandr --output DP-1 --set "Broadcast RGB" "Full"
xrandr --output DP-2 --set "Broadcast RGB" "Full"
xset s off
xset -dpms
