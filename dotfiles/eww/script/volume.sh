#!/bin/bash

# Enhanced Volume Script with Beautiful Notifications
# Uses notification enhancer for animated volume notifications

VOL=$(pamixer --get-volume 2>/dev/null || echo 0)
MUTE=$(pamixer --get-mute 2>/dev/null || echo false)

# Set icons based on volume level and mute status
if [ "$MUTE" = "true" ]; then
    ICON=""
    VOLUME_ICON=""
else
    if [ "$VOL" -eq 0 ]; then
        ICON=""
        VOLUME_ICON=""
    elif [ "$VOL" -le 30 ]; then
        ICON=""
        VOLUME_ICON=""
    elif [ "$VOL" -le 60 ]; then
        ICON=""
        VOLUME_ICON=""
    else
        ICON=""
        VOLUME_ICON=""
    fi
fi

# Export variables for EWW
export VOLUME_ICON=$VOLUME_ICON
export VOLUME_PERCENT="$VOL%"

# Show enhanced notification if this is a volume change event
if [ "$1" = "notify" ]; then
    # Use notification enhancer for beautiful volume notifications
    if command -v "$HOME/Documents/github/archriced/dotfiles/scripts/notification-enhancer.sh" >/dev/null 2>&1; then
        "$HOME/Documents/github/archriced/dotfiles/scripts/notification-enhancer.sh" volume "$VOL" "$MUTE"
    else
        # Fallback to regular notification
        if [ "$MUTE" = "true" ]; then
            notify-send --app-name="volume" --urgency="normal" --icon="audio-volume-muted" "🔇 Audio Muted"
        else
            notify-send --app-name="volume" --urgency="normal" --icon="audio-volume-high" "🔊 Volume: $VOL%"
        fi
    fi
fi

# Output for EWW widget
echo "$ICON $VOL%" 