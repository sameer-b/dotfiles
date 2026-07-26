#!/usr/bin/env bash
# Simple wallpaper automation script for hyprpaper

CACHE="$HOME/.cache/hyprland"
INTERVAL=600

while true; do
  DIR="${WALLPAPER_DIR:-$HOME/Pictures/wallpapers}"
  if [ -d "$DIR" ]; then
    WALLPAPER=$(find "$DIR" -type f \( -name '*.jpg' -o -name '*.png' -o -name '*.jpeg' \) | shuf -n 1)
    if [ -n "$WALLPAPER" ]; then
      mkdir -p "$CACHE"
      echo "$WALLPAPER" > "$CACHE/current_wallpaper"
      if command -v swww &>/dev/null; then
        swww img "$WALLPAPER"
      elif command -v hyprpaper &>/dev/null; then
        hyprctl hyprpaper wallpaper ",$WALLPAPER"
      fi
    fi
  fi
  sleep $INTERVAL
done
