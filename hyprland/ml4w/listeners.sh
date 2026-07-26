#!/usr/bin/env bash
# Minimal listeners manager - registers no listeners by default
declare -A LISTENERS

start_listener() {
    local script_name="$1"
    local script_path="${LISTENERS[$script_name]}"
    [ -z "$script_path" ] && return 1
    [ ! -f "$script_path" ] && return 1
    pgrep -f "$script_path" >/dev/null && return 0
    nohup "$script_path" >/dev/null 2>&1 &
}

stop_listener() {
    local script_name="$1"
    local script_path="${LISTENERS[$script_name]}"
    [ -z "$script_path" ] && return 1
    local pid=$(pgrep -f "$script_path")
    [ -n "$pid" ] && kill $pid 2>/dev/null
}

case "$1" in
--startall) for key in "${!LISTENERS[@]}"; do start_listener "$key"; done ;;
--stopall)  for key in "${!LISTENERS[@]}"; do stop_listener "$key"; done ;;
esac
