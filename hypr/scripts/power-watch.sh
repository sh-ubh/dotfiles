#!/usr/bin/env bash
# Watches AC adapter state and switches eDP-1 refresh rate + power profile
# Runs in background at Hyprland startup

export HYPRLAND_INSTANCE_SIGNATURE=$(ls /run/user/1000/hypr/ 2>/dev/null | head -1)

apply() {
    local status=$(cat /sys/class/power_supply/ADP0/online 2>/dev/null || echo "1")
    if [ "$status" = "1" ]; then
        hyprctl eval "hl.monitor({output='eDP-1', mode='2560x1600@240', position='2560x0', scale=1.33})"
        asusctl profile set Performance
	powerprofilesctl set performance
        notify-send -u low "Power" "AC connected — 240Hz, Performance"
    else
        hyprctl eval "hl.monitor({output='eDP-1', mode='2560x1600@60', position='2560x0', scale=1.33})"
        asusctl profile set Quiet
	powerprofilesctl set power-saver
        notify-send -u low "Power" "On battery — 60Hz, Quiet"
    fi
}

prev=$(cat /sys/class/power_supply/ADP0/online 2>/dev/null || echo "1")

# Apply immediately on startup
apply

while true; do
    sleep 3
    curr=$(cat /sys/class/power_supply/ADP0/online 2>/dev/null || echo "1")
    if [ "$curr" != "$prev" ]; then
        apply
        prev="$curr"
    fi
done
