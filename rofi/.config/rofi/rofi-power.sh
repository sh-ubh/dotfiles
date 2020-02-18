#!/usr/bin/env bash

OPTIONS="Reboot\nShut-down\nSuspend\nLock"

# source configuration or use default values
  LAUNCHER="rofi -location 5 -width 15 -lines 4 -dmenu -i -p power -show-icons "
  USE_LOCKER="true"
  LOCKER="/home/ssaini/.config/lock.sh"


# Show exit wm option if exit command is provided as an argument
if [ ${#1} -gt 0 ]; then
  OPTIONS="Exit window manager\n$OPTIONS"
fi

option=`echo -e $OPTIONS | $LAUNCHER | awk '{print $1}' | tr -d '\r\n'`
if [ ${#option} -gt 0 ]
then
    case $option in
      Exit)
        eval $1
        ;;
      Reboot)
        sudo reboot
        ;;
      Shut-down)
        sudo poweroff
        ;;
      Suspend)
	suspend
        ;;
      Lock)
        /home/ssaini/.local/bin/lock
        ;;
      *)
        ;;
    esac
fi
