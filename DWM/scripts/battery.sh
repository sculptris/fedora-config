#!/bin/sh
# dwmblocks battery script

if [ -d /sys/class/power_supply/BAT0 ]; then
    capacity=$(cat /sys/class/power_supply/BAT0/capacity 2>/dev/null)
    status=$(cat /sys/class/power_supply/BAT0/status 2>/dev/null)

    case "$status" in
        Charging)
            echo "󰂄  ${capacity}%"
            ;;
        Full)
            echo "󰁹  ${capacity}%"
            ;;
        *)
            # Discharging - show different icons based on level
            if [ "$capacity" -ge 75 ]; then
                echo "󰁹  ${capacity}%"
            elif [ "$capacity" -ge 50 ]; then
                echo "󰂀  ${capacity}%"
            elif [ "$capacity" -ge 25 ]; then
                echo "󰂁  ${capacity}%"
            else
                echo "󰂂  ${capacity}%"
            fi
            ;;
    esac
else
    # No battery (desktop)
    echo "󱈑  AC"
fi
