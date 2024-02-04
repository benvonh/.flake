#!/usr/bin/env bash

clamp() {
  max=5
  min=1

  if [[ $1 -ge $max ]]; then
    printf $max
  elif [[ $1 -le $min ]]; then
    printf $min
  else
    printf $1
  fi
}

if [[ "$1" == "up" ]]; then
  target=$(clamp $(($2 + 1)))
else
  target=$(clamp $(($2 - 1)))
fi

hyprctl dispatch workspace $target
