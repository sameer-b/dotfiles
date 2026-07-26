#!/usr/bin/env bash

if [[ "$1" == "menu" ]]; then
  sinks=$(wpctl status | grep -oP '\d+\.\s+\S.*\[vol:.*?\]' | sed 's/^[[:space:]]*//')
  if [[ -z "$sinks" ]]; then
    rofi -dmenu -p "No audio devices" -theme ~/.config/rofi/config.rasi <<<""
    exit 0
  fi
  chosen=$(echo "$sinks" | rofi -dmenu -p "Audio Device" -theme ~/.config/rofi/config.rasi)
  if [[ -n "$chosen" ]]; then
    id=$(echo "$chosen" | grep -oP '^\d+')
    if [[ -n "$id" ]]; then
      wpctl set-default "$id"
    fi
  fi
  exit 0
fi

volume=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>/dev/null)
if [[ "$volume" == *"MUTED"* ]]; then
  pct=$(echo "$volume" | awk '{print int($2 * 100)}')
  printf '{"text":" %s%%","alt":"muted","class":"muted"}\n' "$pct"
else
  pct=$(echo "$volume" | awk '{print int($2 * 100)}')
  if (( pct <= 0 )); then
    icon=""
  elif (( pct < 50 )); then
    icon=""
  else
    icon=""
  fi
  printf '{"text":"%s %s%%","alt":"unmuted","class":"unmuted"}\n' "$icon" "$pct"
fi
