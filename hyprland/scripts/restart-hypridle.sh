#!/usr/bin/env bash

source "$HOME/.config/hypr/scripts/lib/notify.sh"

notify_user --a "hypridle" \
            --i "dialog-information" \
            --s "Hypridle has been restarted" \
            --t 2000
sleep 1
killall hypridle
hypridle
