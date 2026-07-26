#!/usr/bin/env bash

source "$HOME/.config/hypr/scripts/lib/notify.sh"

notify_user --a "hypridle" \
            --i "dialog-information" \
            --s "Gamemode loaded" \
            --m "Animations disabled." \
            --t 2000

sleep 1
hyprctl eval "activate_gamemode()"
mkdir -p "$HOME/.cache/hyprland"
touch "$HOME/.cache/hyprland/gamemode-enabled"
