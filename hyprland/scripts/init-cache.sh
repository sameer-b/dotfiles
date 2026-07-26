#!/bin/bash
# Initialize hyprland cache files

HYPR_CACHE="$HOME/.cache/hyprland"
BLANK_WALL="$HOME/.config/hypr/assets/blank.png"

mkdir -p "$HYPR_CACHE"

if [ ! -f "$HYPR_CACHE/current_wallpaper" ]; then
  echo "$BLANK_WALL" > "$HYPR_CACHE/current_wallpaper"
fi
if [ ! -f "$HYPR_CACHE/blurred_wallpaper.png" ]; then
  cp "$BLANK_WALL" "$HYPR_CACHE/blurred_wallpaper.png"
fi
if [ ! -f "$HYPR_CACHE/square_wallpaper.png" ]; then
  cp "$BLANK_WALL" "$HYPR_CACHE/square_wallpaper.png"
fi
