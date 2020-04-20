#exec dbus-launch --exit-with-session spectrwm
xrdb ~/.Xresources &
xset s 600 &
exec dbus-launch --exit-with-session spectrwm
