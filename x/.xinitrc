#exec dbus-launch --exit-with-session spectrwm
#xrdb ~/.Xresources &
xset b off &
xset s 600 &
~/bin/xss &
~/.fehbg &
picom 2>/dev/null &
xsetroot -name "bat $(cat /sys/class/power_supply/BAT0/capacity)"
exec dbus-launch --exit-with-session startdwm
