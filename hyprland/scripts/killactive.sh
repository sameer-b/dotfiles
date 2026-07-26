#!/bin/bash

ACTIVE_TITLE=$(hyprctl activewindow -j | jq -r '.title')

if [ -z "$ACTIVE_TITLE" ] || [ "$ACTIVE_TITLE" == "null" ]; then
    exit 0
fi

hyprctl dispatch killactive ""
