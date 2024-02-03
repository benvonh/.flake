#!/usr/bin/env bash

while true; do
  vol=$(pamixer --get-volume)

  if [[ $vol -le 1 ]]; then
    icon=' '
  elif [[ $vol -le 50 ]]; then
    icon=' '
  else
    icon=' '
  fi

  echo "$icon$vol%"
  sleep 1
done
