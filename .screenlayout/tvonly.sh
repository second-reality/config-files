#!/bin/sh
xrandr --output eDP-1 --off --output HDMI-1 --mode 1920x1080 --pos 0x0 --rotate normal --output DP-1 --off --output HDMI-2 --off --output DP-2 --off --output HDMI-3 --off
pactl load-module module-combine-sink
xset s off
xset -dpms
