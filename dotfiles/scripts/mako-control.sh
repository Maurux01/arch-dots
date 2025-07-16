#!/bin/bash

# Mako Control Script
# Enhanced notification management for Mako

set -e

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

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
        else
            print_error "Failed to stop Mako"
            return 1
        fi
    else
        print_warning "Mako is not running"
    fi
}

# Restart mako
restart_mako() {
    print_step "Restarting Mako..."
    stop_mako
    sleep 2
    start_mako
}

# Show mako status
status_mako() {
    if check_mako; then
        print_success "Mako is running (PID: $(pgrep mako))"
        echo "Configuration: ~/.config/mako/config"
        echo "Logs: journalctl --user -u mako"
    else
        print_error "Mako is not running"
    fi
}

# Test notifications
test_notifications() {
    print_step "Testing notifications..."
    
    # Test different notification types
    notify-send --app-name="test" --urgency="low" "Test Low Priority" "This is a low priority notification"
    sleep 1
    notify-send --app-name="test" --urgency="normal" "Test Normal Priority" "This is a normal priority notification"
    sleep 1
    notify-send --app-name="test" --urgency="critical" "Test Critical Priority" "This is a critical priority notification"
    sleep 1
    
    # Test app-specific notifications
    notify-send --app-name="spotify" "Music Player" "Now playing: Test Song"
    sleep 1
    notify-send --app-name="firefox" "Web Browser" "Page loaded successfully"
    sleep 1
    notify-send --app-name="code-oss" "Code Editor" "File saved successfully"
    
    print_success "Test notifications sent"
}

# Dismiss all notifications
dismiss_all() {
    print_step "Dismissing all notifications..."
    makoctl dismiss --all
    print_success "All notifications dismissed"
}

# Show notification history
show_history() {
    print_step "Showing notification history..."
    makoctl list
}

# Configure mako
configure_mako() {
    print_step "Opening Mako configuration..."
    if command -v code-oss > /dev/null; then
        code-oss ~/.config/mako/config
    elif command -v nvim > /dev/null; then
        kitty -e nvim ~/.config/mako/config
    elif command -v nano > /dev/null; then
        nano ~/.config/mako/config
    else
        print_error "No suitable editor found"
        return 1
    fi
}

# Show help
show_help() {
    echo "Mako Control Script"
    echo ""
    echo "Usage: $0 [COMMAND]"
    echo ""
    echo "Commands:"
    echo "  start     - Start Mako notification daemon"
    echo "  stop      - Stop Mako notification daemon"
    echo "  restart   - Restart Mako notification daemon"
    echo "  status    - Show Mako status"
    echo "  test      - Test notifications"
    echo "  dismiss   - Dismiss all notifications"
    echo "  history   - Show notification history"
    echo "  config    - Open Mako configuration"
    echo "  help      - Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0 start      # Start Mako"
    echo "  $0 test       # Test notifications"
    echo "  $0 status     # Check status"
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
        restart_mako
        ;;
    status)
        status_mako
        ;;
    test)
        test_notifications
        ;;
    dismiss)
        dismiss_all
        ;;
    history)
        show_history
        ;;
    config)
        configure_mako
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