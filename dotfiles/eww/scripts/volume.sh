#!/bin/bash
VOL=$(pamixer --get-volume 2>/dev/null || echo 0)
MUTE=$(pamixer --get-mute 2>/dev/null || echo false)
if [ "$MUTE" = "true" ]; then
  ICON=""
else
  ICON=""
fi
export VOLUME_ICON=$ICON
export VOLUME_PERCENT="$VOL%"
echo $ICON $VOL% 