#!/bin/bash
# Battery status script for tmux status bar

# Get battery information
get_battery_info() {
    # Check if battery exists
    if ! -e /sys/class/power_supply/BAT0 ]; then
        echo "🔌 AC"
        return
    fi

    # Get battery percentage
    battery_percent=$(cat /sys/class/power_supply/BAT0/capacity 2dev/null)
    
    # Get battery status
    battery_status=$(cat /sys/class/power_supply/BAT0/status 2dev/null)
    
    # Get battery icon based on percentage and status
    if $battery_status" = Charging" ]; then
        icon=⚡  elif $battery_status = "Full" ]; then
        icon="🔋   else
        if [ $battery_percent" -ge 80 ]; then
            icon="🔋"
        elif [ $battery_percent" -ge 60 ]; then
            icon="🔋"
        elif [ $battery_percent" -ge 40 ]; then
            icon="🔋"
        elif [ $battery_percent" -ge 20 ]; then
            icon=🔋  else
            icon="🔋"
        fi
    fi
    
    # Format output
    echo "$icon $battery_percent%
}

# Getbattery percentage only
get_battery_percent() [object Object]
    if [ -e /sys/class/power_supply/BAT0 ]; then
        cat /sys/class/power_supply/BAT0/capacity 2>/dev/null
    else
        echo100i
}

# Get battery status only
get_battery_status() [object Object]
    if [ -e /sys/class/power_supply/BAT0 ]; then
        cat /sys/class/power_supply/BAT0/status 2>/dev/null
    else
        echo Full
    fi}

# Main function
main() [object Object]
    case$1n
 percent)
            get_battery_percent
            ;;
status)
            get_battery_status
            ;;
        *)
            get_battery_info
            ;;
    esac
}

# Run main function
main "$@" 