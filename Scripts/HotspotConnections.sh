#!/bin/bash

# Check if the Wi-Fi interface is specified as the first argument, else use a default one
INTERFACE=${1:-wlp0s20f3}

# Scan the connected devices and extract their MAC addresses
echo "Devices Connected: "
MAC_ADDRESSES=$(iw dev "$INTERFACE" station dump | grep Station | awk '{print $2}')

# Check if there are any devices connected
if [ -z "$MAC_ADDRESSES" ]; then
  echo "No devices found connected to the hotspot."
  exit 0
fi

# Print the MAC addresses and the total number of devices
echo "$MAC_ADDRESSES"
echo "Total Number of Devices: "
echo "$MAC_ADDRESSES" | wc -l

