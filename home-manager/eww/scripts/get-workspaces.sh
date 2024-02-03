#!/usr/bin/env bash

workspaces() {
  echo "[{\"id\":1,\"icon\":\" \"},"\
        "{\"id\":2,\"icon\":\" \"},"\
        "{\"id\":3,\"icon\":\" \"},"\
        "{\"id\":4,\"icon\":\" \"},"\
        "{\"id\":5,\"icon\":\" \"}]"
}

workspaces
socat -u UNIX-CONNECT:/tmp/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock - | \
  while read -r; do
    workspaces
  done
