#!/bin/bash
BAT=$(cat /sys/class/power_supply/BAT*/capacity 2>/dev/null | head -n1)
STATUS=$(cat /sys/class/power_supply/BAT*/status 2>/dev/null | head -n1)
if [ "$STATUS" = "Charging" ]; then
  ICON=""
else
  ICON=""
fi
export BATTERY_ICON=$ICON
export BATTERY_PERCENT="$BAT%"
echo $ICON $BAT% 