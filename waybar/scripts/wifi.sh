#!/usr/bin/env bash

if [[ "$1" == "menu" ]]; then
  networks=$(nmcli -t -f SSID,SIGNAL,SECURITY device wifi list 2>/dev/null | head -30)
  if [[ -z "$networks" ]]; then
    rofi -dmenu -p "No networks found" -theme ~/.config/rofi/config.rasi <<<""
    exit 0
  fi
  chosen=$(echo "$networks" | rofi -dmenu -p "Wi-Fi Network" -theme ~/.config/rofi/config.rasi)
  if [[ -n "$chosen" ]]; then
    ssid=$(echo "$chosen" | awk -F: '{print $1}')
    if [[ -n "$ssid" ]]; then
      nmcli device wifi connect "$ssid" 2>/dev/null || nmcli --ask device wifi connect "$ssid"
    fi
  fi
  exit 0
fi

wifi_enabled=$(nmcli -t -f WIFI g 2>/dev/null)
wifi_connected=$(nmcli -t -f DEVICE,STATE d 2>/dev/null | grep "^wlan0:connected\|^wlp.*:connected" | head -1)
eth_connected=$(nmcli -t -f DEVICE,STATE d 2>/dev/null | grep "^en.*:connected" | head -1)

if [[ -n "$wifi_connected" ]]; then
  signal=$(nmcli -t -f SIGNAL device wifi list 2>/dev/null | head -1)
  printf '{"text":" %s%%","alt":"wifi","class":"connected"}\n' "${signal:-0}"
elif [[ -n "$eth_connected" ]]; then
  printf '{"text":" online","alt":"ethernet","class":"connected"}\n'
elif [[ "$wifi_enabled" == "enabled" ]]; then
  signal=$(nmcli -t -f SIGNAL device wifi list 2>/dev/null | head -1)
  printf '{"text":" %s%%","alt":"wifi","class":"disconnected"}\n' "${signal:-0}"
else
  printf '{"text":" off","alt":"disabled","class":"disabled"}\n'
fi
