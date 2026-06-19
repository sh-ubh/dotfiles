#!/usr/bin/env bash

# Power menu using wofi

lock="󰌾  Lock"
sleep="󰒲  Sleep"
restart="󰑓  Restart"
shutdown="󰐥  Shutdown"
logout="󰍃  Logout"

chosen=$(printf '%s\n' "$lock" "$sleep" "$restart" "$shutdown" "$logout" \
    | wofi \
        --dmenu \
        --prompt "Power" \
        --width 220 \
        --height 240 \
        --cache-file /dev/null \
        --hide-scroll \
        --no-actions \
        --insensitive)

case "$chosen" in
    "$lock")     hyprlock ;;
    "$sleep")    systemctl suspend ;;
    "$restart")  hyprshutdown -t 'Restarting...' --post-cmd 'systemctl reboot' ;;
    "$shutdown") hyprshutdown -t 'Shutting down...' --post-cmd 'systemctl poweroff' ;;
    "$logout")   hyprshutdown ;;
esac
