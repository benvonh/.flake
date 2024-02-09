#!/usr/bin/env bash

BATTERY='/sys/class/power_supply/BAT0'

if [[ ! -d $BATTERY ]]; then
  sleep 10
  notify-send "$SCRIPT" "No battery detected at $BATTERY"
  exit 1
fi

print_status() {
    echo "${icons[$icons_idx]} $capacity%"
}

icons=(' ' ' ' ' ' ' ' ' ')
icons_idx=0
low_battery=0
prev_status=$(cat "$BATTERY/status")

while true; do
  curr_status=$(cat "$BATTERY/status")
  capacity=$(cat "$BATTERY/capacity")

  # Notify change in charging state
  if [[ "$curr_status" != "$prev_status" ]]; then
    notify-send "Battery" "$curr_status..."
    prev_status="$curr_status"
  fi

  # While charging...
  if [[ "$curr_status" == 'Charging' ]]; then
    # Animate battery icon
    if [[ $icons_idx -ge 4 ]]; then
      icons_idx=1
    else
      ((icons_idx++))
    fi
    # Unset low battery flag
    if [[ $capacity -gt 10 ]]; then
      low_battery=0
    fi
  # While discharging...
  elif [[ "$curr_status" == 'Discharging' ]]; then
    # Set battery icon level
    if [[ $capacity -lt 20 ]]; then
      icons_idx=0
    elif [[ $capacity -lt 40 ]]; then
      icons_idx=1
    elif [[ $capacity -lt 60 ]]; then
      icons_idx=2
    elif [[ $capacity -lt 80 ]]; then
      icons_idx=3
    else
      icons_idx=4
    fi
    # Set low battery flag and notify
    if [[ $low_battery -eq 0 && $capacity -lt 10 ]]; then
      notify-send -u critical "Battery" "Low battery"
      low_battery=1
    fi
  fi

  print_status
  sleep 1
done
