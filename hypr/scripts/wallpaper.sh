#!/usr/bin/env bash

WALLS_DIR="$HOME/Pictures/walls"

# Start the daemon
awww-daemon &
sleep 1

# Pick a random wallpaper and set it
WALL=$(find "$WALLS_DIR" -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.gif" -o -name "*.webp" \) | shuf -n1)

if [ -n "$WALL" ]; then
    awww img "$WALL" --transition-type random
fi
