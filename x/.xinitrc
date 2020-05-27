#!/bin/bash
#.xinitrc
xset b off &
xset s 600 &
# ~/bin/xss &
# ~/.fehbg &
# ~/bin/batcheck &
# picom 2>/dev/null &
# dwmbar &

exec dbus-launch --exit-with-session spectrwm
