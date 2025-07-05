#!/bin/bash

# Enhanced Brightness Script with Beautiful Notifications
# Uses notification enhancer for animated brightness notifications

# Get brightness value (works with most backlight systems)
BRIGHTNESS=$(brightnessctl get 2>/dev/null || echo 0)
MAX_BRIGHTNESS=$(brightnessctl max 2>/dev/null || echo 100)
PERCENT=$((BRIGHTNESS * 100 / MAX_BRIGHTNESS))

# Set icons based on brightness level
if [ "$PERCENT" -eq 0 ]; then
    ICON=""
    BRIGHTNESS_ICON=""
elif [ "$PERCENT" -le 25 ]; then
    ICON=""
    BRIGHTNESS_ICON=""
elif [ "$PERCENT" -le 50 ]; then
    ICON=""
    BRIGHTNESS_ICON=""
elif [ "$PERCENT" -le 75 ]; then
    ICON=""
    BRIGHTNESS_ICON=""
else
    ICON=""
    BRIGHTNESS_ICON=""
fi

# Export variables for EWW
export BRIGHTNESS_ICON=$BRIGHTNESS_ICON
export BRIGHTNESS_PERCENT="$PERCENT%"

# Show enhanced notification if this is a brightness change event
if [ "$1" = "notify" ]; then
    # Use notification enhancer for beautiful brightness notifications
    if command -v "$HOME/Documents/github/archriced/dotfiles/scripts/notification-enhancer.sh" >/dev/null 2>&1; then
        "$HOME/Documents/github/archriced/dotfiles/scripts/notification-enhancer.sh" brightness "$PERCENT"
    else
        # Fallback to regular notification
        notify-send --app-name="brightness" --urgency="normal" --icon="display-brightness" "☀️ Brightness: $PERCENT%"
    fi
fi

# Output for EWW widget
echo "$ICON $PERCENT%" 