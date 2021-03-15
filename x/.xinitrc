#!/bin/bash
setxkbmap -layout us -option caps:ctrl_modifier &
xcape -e 'Caps_Lock=Escape' &
xinput --disable "ETPS/2 Elantech Touchpad"
exec dbus-run-session bspwm
