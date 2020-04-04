#!/bin/bash
while true
do
    battery_level=$(cat /sys/class/power_supply/BAT0/capacity)
    if [ $battery_level -ge 95 ]; then
       notify-send 'Pull the plug!' $battery_level%
    elif [ $battery_level -le 30 -a $battery_level -ge 20 ]; then
       notify-send 'Plug me!' $battery_level%
    elif [ $battery_level -le 20 ]; then
       notify-send -u critical 'Plug me NOW!' $battery_level%
    fi
    sleep 300 # 300 seconds or 5 minutes
done
