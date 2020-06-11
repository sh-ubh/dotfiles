#!/bin/bash
#.xinitrc
xset b off &
xset s 600 &
exec dbus-launch --exit-with-session spectrwm
