#!/bin/bash
#.xinitrc
/usr/bin/prime-offload &
xrdb -merge ~/.Xresources &
xss-lock -- slock &
xset b off &
xset s 300 &
setxkbmap -layout us -option caps:ctrl_modifier &
xcape -e 'Caps_Lock=Escape' &
# xrandr --setprovideroutputsource modesetting NVIDIA-0
# xrandr --auto
~/.fehbg &
urxvtd &
~/.local/bin/bat_check.sh &
picom &
dunst &
exec spectrwm
