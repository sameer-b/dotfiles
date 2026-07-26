#!/usr/bin/env bash
# Initialize wallpaper on startup

if command -v swww &>/dev/null; then
  swww init
fi

~/.config/hypr/scripts/wallpaper.sh --restore
