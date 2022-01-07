#!/bin/sh
# Times the screen off and puts it to background
# swayidle \
#     timeout  5 'swaymsg "output * dpms off"' \
#     resume 'swaymsg "output * dpms on"' &
# Locks the screen immediately
setxkbmap us
swaylock -f --screenshots --effect-pixelate 10
systemctl suspend
# Kills last background task so idle timer doesn't keep running
