#!/usr/bin/env bash

usage=$(top -bn1 | grep "Cpu(s)" | awk '{print int($2)}')
temp=$(sensors 2>/dev/null | grep "Tctl" | grep -oP '\d+' | head -1)

if [[ -z "$temp" ]]; then
  temp=$(sensors 2>/dev/null | grep -m1 "temp1" | grep -oP '\d+' | head -1)
fi

usage=${usage:-0}
temp=${temp:-0}

printf '{"text":" %s°C %s%%","alt":"cpu","class":""}\n' "$temp" "$usage"
