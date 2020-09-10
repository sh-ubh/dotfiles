#!/bin/bash
#/usr/bin/prime-offload &
xrdb -merge ~/.Xresources &
setxkbmap -layout us -option caps:ctrl_modifier &
xcape -e 'Caps_Lock=Escape' &
# xrandr --setprovideroutputsource modesetting NVIDIA-0
# xrandr --auto
# exec dbus-launch --exit-with-session bspwm
exec dbus-run-session bspwm
