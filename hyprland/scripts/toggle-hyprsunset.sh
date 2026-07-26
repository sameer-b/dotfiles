#!/usr/bin/env bash
# Toggle hyprsunset on/off

if pgrep -x hyprsunset >/dev/null; then
  pkill hyprsunset
  notify-send -t 2000 "Hyprsunset" "Disabled"
else
  hyprsunset -t 4000 &
  notify-send -t 2000 "Hyprsunset" "Enabled (4000K)"
fi
