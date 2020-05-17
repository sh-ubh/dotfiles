#!/bin/bash
#.xinitrc
xset b off &
xset s 600 &
~/bin/xss &
~/.fehbg &
picom 2>/dev/null &
dwmbar &

exec dbus-launch --exit-with-session startdwm
