#!/usr/bin/env bash

if command -v nvidia-smi &>/dev/null; then
  gpu_info=$(nvidia-smi --query-gpu=temperature.gpu,utilization.gpu --format=csv,noheader 2>/dev/null)
  if [[ -n "$gpu_info" ]]; then
    temp=$(echo "$gpu_info" | awk -F', ' '{print int($1)}')
    util=$(echo "$gpu_info" | awk -F', ' '{print int($2)}')
    printf '{"text":" %s°C %s%%","alt":"nvidia","class":""}\n' "$temp" "$util"
    exit 0
  fi
fi

if command -v radeontop &>/dev/null; then
  util=$(radeontop -d - -l 1 2>/dev/null | grep -oP 'gpu\s+\d+' | awk '{print $2}')
  printf '{"text":" %s°C %s%%","alt":"amd","class":""}\n' "?" "${util:-0}"
  exit 0
fi

printf '{"text":" N/A","alt":"none","class":"disabled"}\n'
