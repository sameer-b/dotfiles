#!/usr/bin/env bash

HYPR_CACHE="$HOME/.cache/hyprland"
source "$HOME/.config/hypr/scripts/lib/notify.sh"
APP_NAME="System"
NOTIFICATION_ICON="joystick"

if [ -f $HYPR_CACHE/gamemode-enabled ]; then
  hyprctl reload
  rm $HYPR_CACHE/gamemode-enabled
  notify_user --a "${APP_NAME}" \
            --i "${NOTIFICATION_ICON}" \
            --s "Gamemode deactivated" \
            --m "Animations and blur are now enabled."
else
  hyprctl eval "activate_gamemode()"
  mkdir -p "$HYPR_CACHE"
  touch $HYPR_CACHE/gamemode-enabled
  notify_user --a "${APP_NAME}" \
          --i "${NOTIFICATION_ICON}" \
          --s "Gamemode activated" \
          --m "Animations and blur are now disabled."
fi
