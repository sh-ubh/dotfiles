#!/bin/bash
setxkbmap -layout us -option caps:ctrl_modifier &
xcape -e 'Caps_Lock=Escape' &
xinput --disable "ETPS/2 Elantech Touchpad"
xrdb -merge ~/.Xresources &
xsetroot -cursor_name left_ptr &
xset b off &
xset s 300 &
exec dbus-run-session bspwm
