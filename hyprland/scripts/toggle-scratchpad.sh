#!/usr/bin/env bash
# Toggle window in/out of special workspace "magic" (scratchpad)

WINDOW=$(hyprctl activewindow -j | jq -r '.address')

if [ -z "$WINDOW" ] || [ "$WINDOW" == "null" ]; then
  exit 0
fi

hyprctl dispatch movetoworkspacesilent "special:magic,address:$WINDOW"
