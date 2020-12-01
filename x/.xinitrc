#!/bin/bash
xrdb -merge ~/.Xresources &
setxkbmap -layout us -option caps:ctrl_modifier &
xcape -e 'Caps_Lock=Escape' &
exec dbus-run-session bspwm
