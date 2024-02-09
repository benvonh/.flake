#!/usr/bin/env bash

if=$(ip route | awk '/default/ { print $5 }')
rx_old=$(grep $if /proc/net/dev | tr -s ' ' | cut -d' ' -f3)
sleep 1

while true; do
  rx_new=$(grep $if /proc/net/dev | tr -s ' ' | cut -d' ' -f3)
  rx_bytes=$(expr $rx_new - $rx_old)
  rx_mbps=$(echo "scale=2; $rx_bytes/1024" | bc)
  rx_old=$rx_new

  echo "  $rx_mbps MB/s"
  sleep 1
done
