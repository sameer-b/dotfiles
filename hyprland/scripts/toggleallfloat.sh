#!/usr/bin/env bash

hyprctl dispatch workspaceopt allfloat

source "$HOME/.config/hypr/scripts/lib/notify.sh"

notify_user \
    --a "System" \
    --m "Windows on this workspace toggled to floating/tiling"
