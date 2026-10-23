#!/bin/sh
# dwmblocks network script - display WiFi name

# Get active WiFi SSID
if command -v nmcli >/dev/null 2>&1; then
    ssid=$(nmcli -t -f ACTIVE,SSID device wifi 2>/dev/null | grep "^yes:" | cut -d: -f2)
    if [ -n "$ssid" ]; then
        echo "󰤨  $ssid"
    else
        # Wired connection
        status=$(nmcli -t -f ACTIVE,TYPE,DEVICE connection 2>/dev/null | grep "^yes:ethernet:" | head -1)
        if [ -n "$status" ]; then
            device=$(echo "$status" | cut -d: -f3)
            echo "󰤨  $device"
        else
            echo "󰤨  disconnected"
        fi
    fi
else
    echo "󰤨  N/A"
fi
