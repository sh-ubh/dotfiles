#!/bin/bash
xinput --disable "ETPS/2 Elantech Touchpad"
xrdb -merge ~/.Xresources &
xsetroot -cursor_name left_ptr &
xset b off &
xset s 300 &
exec dbus-run-session bspwm
