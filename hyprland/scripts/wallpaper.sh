#!/usr/bin/env bash
# Set wallpaper using hyprpaper or swww

CACHE="$HOME/.cache/hyprland"
WALLPAPER=""

restore() {
  WALLPAPER=$(cat "$CACHE/current_wallpaper" 2>/dev/null || echo "")
  [ -z "$WALLPAPER" ] && exit 0
}

random_wall() {
  DIR="${WALLPAPER_DIR:-$HOME/Pictures/wallpapers}"
  [ ! -d "$DIR" ] && exit 0
  WALLPAPER=$(find "$DIR" -type f \( -name '*.jpg' -o -name '*.png' -o -name '*.jpeg' \) | shuf -n 1)
  [ -z "$WALLPAPER" ] && exit 0
}

if [[ "$1" == "--restore" ]]; then
  restore
elif [[ "$1" == "--random" ]]; then
  random_wall
elif [[ -n "$1" ]]; then
  WALLPAPER="$1"
else
  exit 0
fi

mkdir -p "$CACHE"
echo "$WALLPAPER" > "$CACHE/current_wallpaper"

if command -v swww &>/dev/null; then
  swww img "$WALLPAPER"
elif command -v hyprpaper &>/dev/null; then
  hyprctl hyprpaper wallpaper ",$WALLPAPER"
fi
