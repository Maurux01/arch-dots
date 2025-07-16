#!/bin/bash

# Enhanced Notification Manager for Hyprland
# Advanced notification handling with Do Not Disturb, scheduling, and filtering

set -e

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

# Configuration
CONFIG_DIR="$HOME/.config/notification-manager"
DND_FILE="$CONFIG_DIR/dnd_status"
FILTER_FILE="$CONFIG_DIR/notification_filters"
SCHEDULE_FILE="$CONFIG_DIR/notification_schedule"
HISTORY_FILE="$CONFIG_DIR/notification_history"

# Ensure config directory exists
mkdir -p "$CONFIG_DIR"

print_step() {
    echo -e "${BLUE}→ $1${NC}"
}

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

# Check if mako is running
check_mako() {
    if pgrep -x "mako" > /dev/null; then
        return 0
    else
        return 1
    fi
}

# Start mako if not running
start_mako() {
    if ! check_mako; then
        print_step "Starting Mako notification daemon..."
        mako &
        sleep 1
        if check_mako; then
            print_success "Mako started successfully"
            send_notification "normal" "Notifications" "Notification daemon started" "notifications"
        else
            print_error "Failed to start Mako"
            return 1
        fi
    else
        print_warning "Mako is already running"
    fi
}

# Stop mako
stop_mako() {
    if check_mako; then
        print_step "Stopping Mako notification daemon..."
        pkill -x mako
        sleep 1
        if ! check_mako; then
            print_success "Mako stopped successfully"
            send_notification "normal" "Notifications" "Notification daemon stopped" "notifications"
        else
            print_error "Failed to stop Mako"
            return 1
        fi
    else
        print_warning "Mako is not running"
    fi
}

# Send notification with enhanced features
send_notification() {
    local urgency="$1"
    local title="$2"
    local message="$3"
    local icon="$4"
    local app_name="${5:-notification-manager}"
    
    # Check Do Not Disturb status
    if is_dnd_active; then
        print_warning "Do Not Disturb is active, notification suppressed"
        return 0
    fi
    
    # Check notification filters
    if is_notification_filtered "$title" "$message"; then
        print_warning "Notification filtered: $title"
        return 0
    fi
    
    # Check notification schedule
    if ! is_notification_allowed_now; then
        print_warning "Notifications not allowed at this time"
        return 0
    fi
    
    # Send the notification
    notify-send --urgency="$urgency" \
                --app-name="$app_name" \
                --icon="$icon" \
                "$title" \
                "$message"
    
    # Log to history
    log_notification "$title" "$message" "$urgency"
}

# Do Not Disturb functionality
is_dnd_active() {
    if [ -f "$DND_FILE" ]; then
        local status=$(cat "$DND_FILE")
        if [ "$status" = "active" ]; then
            return 0
        fi
    fi
    return 1
}

enable_dnd() {
    echo "active" > "$DND_FILE"
    print_success "Do Not Disturb enabled"
    send_notification "normal" "Do Not Disturb" "Notifications disabled" "notifications-off"
}

disable_dnd() {
    rm -f "$DND_FILE"
    print_success "Do Not Disturb disabled"
    send_notification "normal" "Do Not Disturb" "Notifications enabled" "notifications"
}

toggle_dnd() {
    if is_dnd_active; then
        disable_dnd
    else
        enable_dnd
    fi
}

# Notification filtering
is_notification_filtered() {
    local title="$1"
    local message="$2"
    
    if [ ! -f "$FILTER_FILE" ]; then
        return 1
    fi
    
    while IFS= read -r filter; do
        if [[ "$title" =~ $filter ]] || [[ "$message" =~ $filter ]]; then
            return 0
        fi
    done < "$FILTER_FILE"
    
    return 1
}

add_filter() {
    local filter="$1"
    echo "$filter" >> "$FILTER_FILE"
    print_success "Filter added: $filter"
}

remove_filter() {
    local filter="$1"
    if [ -f "$FILTER_FILE" ]; then
        sed -i "/$filter/d" "$FILTER_FILE"
        print_success "Filter removed: $filter"
    fi
}

list_filters() {
    if [ -f "$FILTER_FILE" ]; then
        echo "Active notification filters:"
        cat "$FILTER_FILE"
    else
        echo "No filters configured"
    fi
}

# Notification scheduling
is_notification_allowed_now() {
    if [ ! -f "$SCHEDULE_FILE" ]; then
        return 0
    fi
    
    local current_hour=$(date +%H)
    local current_day=$(date +%u)  # 1=Monday, 7=Sunday
    
    while IFS= read -r schedule; do
        local day=$(echo "$schedule" | cut -d' ' -f1)
        local start_hour=$(echo "$schedule" | cut -d' ' -f2)
        local end_hour=$(echo "$schedule" | cut -d' ' -f3)
        
        if [ "$day" = "$current_day" ] || [ "$day" = "all" ]; then
            if [ "$current_hour" -ge "$start_hour" ] && [ "$current_hour" -lt "$end_hour" ]; then
                return 0
            fi
        fi
    done < "$SCHEDULE_FILE"
    
    return 1
}

add_schedule() {
    local day="$1"
    local start_hour="$2"
    local end_hour="$3"
    
    echo "$day $start_hour $end_hour" >> "$SCHEDULE_FILE"
    print_success "Schedule added: $day $start_hour-$end_hour"
}

remove_schedule() {
    local pattern="$1"
    if [ -f "$SCHEDULE_FILE" ]; then
        sed -i "/$pattern/d" "$SCHEDULE_FILE"
        print_success "Schedule removed: $pattern"
    fi
}

list_schedule() {
    if [ -f "$SCHEDULE_FILE" ]; then
        echo "Notification schedule:"
        cat "$SCHEDULE_FILE"
    else
        echo "No schedule configured"
    fi
}

# Notification history
log_notification() {
    local title="$1"
    local message="$2"
    local urgency="$3"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    
    echo "$timestamp|$urgency|$title|$message" >> "$HISTORY_FILE"
}

show_history() {
    local limit="${1:-50}"
    
    if [ -f "$HISTORY_FILE" ]; then
        echo "Recent notifications (last $limit):"
        tail -n "$limit" "$HISTORY_FILE" | while IFS='|' read -r timestamp urgency title message; do
            echo "[$timestamp] [$urgency] $title: $message"
        done
    else
        echo "No notification history"
    fi
}

clear_history() {
    rm -f "$HISTORY_FILE"
    print_success "Notification history cleared"
}

# Test notifications with different types
test_notifications() {
    print_step "Testing notifications..."
    
    # Test different urgency levels
    send_notification "low" "Test Low Priority" "This is a low priority notification" "info"
    sleep 1
    send_notification "normal" "Test Normal Priority" "This is a normal priority notification" "info"
    sleep 1
    send_notification "critical" "Test Critical Priority" "This is a critical priority notification" "error"
    sleep 1
    
    # Test app-specific notifications
    send_notification "normal" "Music Player" "Now playing: Test Song" "music" "spotify"
    sleep 1
    send_notification "normal" "Web Browser" "Page loaded successfully" "web-browser" "firefox"
    sleep 1
    send_notification "normal" "Code Editor" "File saved successfully" "text-editor" "code-oss"
    
    print_success "Test notifications sent"
}

# Notification statistics
show_stats() {
    if [ -f "$HISTORY_FILE" ]; then
        local total=$(wc -l < "$HISTORY_FILE")
        local critical=$(grep -c "|critical|" "$HISTORY_FILE" || echo "0")
        local normal=$(grep -c "|normal|" "$HISTORY_FILE" || echo "0")
        local low=$(grep -c "|low|" "$HISTORY_FILE" || echo "0")
        
        echo "Notification Statistics:"
        echo "  Total notifications: $total"
        echo "  Critical: $critical"
        echo "  Normal: $normal"
        echo "  Low: $low"
        
        if [ $total -gt 0 ]; then
            local critical_pct=$((critical * 100 / total))
            local normal_pct=$((normal * 100 / total))
            local low_pct=$((low * 100 / total))
            
            echo "  Critical: ${critical_pct}%"
            echo "  Normal: ${normal_pct}%"
            echo "  Low: ${low_pct}%"
        fi
    else
        echo "No notification history available"
    fi
}

# Quick actions
quick_actions() {
    case "$1" in
        "dnd")
            toggle_dnd
            ;;
        "test")
            test_notifications
            ;;
        "clear")
            makoctl dismiss --all
            print_success "All notifications dismissed"
            ;;
        "history")
            show_history
            ;;
        "stats")
            show_stats
            ;;
        "start")
            start_mako
            ;;
        "stop")
            stop_mako
            ;;
        "restart")
            stop_mako
            sleep 1
            start_mako
            ;;
        *)
            print_error "Unknown quick action: $1"
            return 1
            ;;
    esac
}

# Show help
show_help() {
    echo "Enhanced Notification Manager for Hyprland"
    echo ""
    echo "Usage: $0 [COMMAND] [OPTIONS]"
    echo ""
    echo "Commands:"
    echo "  start/stop/restart  - Control Mako daemon"
    echo "  test                - Test notifications"
    echo "  dnd                 - Toggle Do Not Disturb"
    echo "  clear               - Dismiss all notifications"
    echo "  history [limit]     - Show notification history"
    echo "  stats               - Show notification statistics"
    echo "  filter add <pattern> - Add notification filter"
    echo "  filter remove <pattern> - Remove notification filter"
    echo "  filter list         - List all filters"
    echo "  schedule add <day> <start> <end> - Add notification schedule"
    echo "  schedule remove <pattern> - Remove schedule"
    echo "  schedule list       - List all schedules"
    echo "  help                - Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0 dnd              # Toggle Do Not Disturb"
    echo "  $0 test             # Test notifications"
    echo "  $0 filter add 'spam' # Filter spam notifications"
    echo "  $0 schedule add all 9 18 # Allow notifications 9AM-6PM daily"
    echo ""
    echo "Quick Actions:"
    echo "  $0 quick dnd        # Toggle Do Not Disturb"
    echo "  $0 quick test       # Test notifications"
    echo "  $0 quick clear      # Clear all notifications"
}

# Main script logic
case "${1:-help}" in
    start)
        start_mako
        ;;
    stop)
        stop_mako
        ;;
    restart)
        stop_mako
        sleep 1
        start_mako
        ;;
    test)
        test_notifications
        ;;
    dnd)
        toggle_dnd
        ;;
    clear)
        makoctl dismiss --all
        print_success "All notifications dismissed"
        ;;
    history)
        show_history "$2"
        ;;
    stats)
        show_stats
        ;;
    filter)
        case "$2" in
            add)
                add_filter "$3"
                ;;
            remove)
                remove_filter "$3"
                ;;
            list)
                list_filters
                ;;
            *)
                print_error "Unknown filter command: $2"
                ;;
        esac
        ;;
    schedule)
        case "$2" in
            add)
                add_schedule "$3" "$4" "$5"
                ;;
            remove)
                remove_schedule "$3"
                ;;
            list)
                list_schedule
                ;;
            *)
                print_error "Unknown schedule command: $2"
                ;;
        esac
        ;;
    quick)
        quick_actions "$2"
        ;;
    help|--help|-h)
        show_help
        ;;
    *)
        print_error "Unknown command: $1"
        echo ""
        show_help
        exit 1
        ;;
esac 