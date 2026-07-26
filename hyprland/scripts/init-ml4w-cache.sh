#!/usr/bin/env bash
# Initialize ml4w cache files for standalone use (no ml4w framework)
ML4W_CACHE="$HOME/.cache/ml4w/hyprland-dotfiles"
BLANK_WALL="$HOME/.config/hypr/assets/blank.png"

mkdir -p "$ML4W_CACHE"

# Set initial wallpaper
if [ ! -f "$ML4W_CACHE/current_wallpaper" ]; then
  echo "$BLANK_WALL" > "$ML4W_CACHE/current_wallpaper"
fi

# Create blurred/squared wallpaper placeholders for hyprlock
if [ ! -f "$ML4W_CACHE/blurred_wallpaper.png" ]; then
  cp "$BLANK_WALL" "$ML4W_CACHE/blurred_wallpaper.png" 2>/dev/null || true
fi
if [ ! -f "$ML4W_CACHE/square_wallpaper.png" ]; then
  cp "$BLANK_WALL" "$ML4W_CACHE/square_wallpaper.png" 2>/dev/null || true
fi

# Create current_wallpaper.rasi for rofi
if [ ! -f "$ML4W_CACHE/current_wallpaper.rasi" ]; then
  echo '@theme "~/.config/rofi/colors.rasi"' > "$ML4W_CACHE/current_wallpaper.rasi"
fi
