#!/bin/bash

# Power menu script for Waybar
# Shows a power menu with various system options

# Function to show power menu
show_power_menu() {
    # Create a temporary menu file
    menu_file="/tmp/power_menu.txt"
    
    cat > "$menu_file" << 'EOF'
🔒 Lock Screen
⏸️ Suspend
🔄 Reboot
⏻ Shutdown
🚪 Logout
❌ Cancel
EOF

    # Show menu using wofi
    choice=$(cat "$menu_file" | wofi --show dmenu --prompt "Power Menu" --width 200 --height 250)
    
    # Clean up
    rm "$menu_file"
    
    # Execute chosen action
    case "$choice" in
        "🔒 Lock Screen")
            swaylock
            ;;
        "⏸️ Suspend")
            systemctl suspend
            ;;
        "🔄 Reboot")
            systemctl reboot
            ;;
        "⏻ Shutdown")
            systemctl poweroff
            ;;
        "🚪 Logout")
            hyprctl dispatch exit
            ;;
        "❌ Cancel"|"")
            exit 0
            ;;
        *)
            exit 0
            ;;
    esac
}

# Function to show confirmation dialog
show_confirmation() {
    local action="$1"
    local message="$2"
    
    echo -e "⚠️  Confirm $action\n\n$message\n\n✅ Yes\n❌ No" | wofi --show dmenu --prompt "Confirm" --width 300 --height 200
}

# Main execution
show_power_menu 