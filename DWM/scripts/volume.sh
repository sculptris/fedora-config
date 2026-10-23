#!/bin/sh
# dwmblocks volume script

vol=$(amixer get Master | awk -F'[][]' '/%/ {print $2; exit}')
mute=$(amixer get Master | awk '/%/ {print $6; exit}')

if [ "$mute" = "off" ]; then
    echo "󰖁  Mute"
else
    echo "󰕾  ${vol}"
fi
