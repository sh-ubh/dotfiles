#!/bin/bash
setxkbmap -layout us -option caps:ctrl_modifier &
xcape -e 'Caps_Lock=Escape' &
xinput --disable 13
exec dbus-run-session bspwm
