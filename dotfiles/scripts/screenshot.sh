#!/bin/bash

# Enhanced Screenshot Script for Hyprland
# Supports multiple capture modes with notifications and clipboard integration

set -e

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

# Configuration
SCREENSHOT_DIR="$HOME/Pictures/Screenshots"
TEMP_DIR="/tmp"
DATE_FORMAT="%Y%m%d_%H%M%S"
MAX_RETRIES=3

# Ensure screenshot directory exists
mkdir -p "$SCREENSHOT_DIR"

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

# Send notification with different priorities
send_notification() {
    local urgency="$1"
    local title="$2"
    local message="$3"
    local icon="$4"
    
    notify-send --urgency="$urgency" \
                --app-name="screenshot" \
                --icon="$icon" \
                "$title" \
                "$message"
}

# Check if required tools are available
check_dependencies() {
    local missing_deps=()
    
    # Check for screenshot tools
    if ! command -v wl-screenshot > /dev/null && ! command -v grim > /dev/null; then
        missing_deps+=("wl-screenshot or grim")
    fi
    
    # Check for image processing tools
    if ! command -v convert > /dev/null; then
        missing_deps+=("imagemagick")
    fi
    
    # Check for clipboard tools
    if ! command -v wl-copy > /dev/null && ! command -v xclip > /dev/null; then
        missing_deps+=("wl-copy or xclip")
    fi
    
    if [ ${#missing_deps[@]} -gt 0 ]; then
        print_error "Missing dependencies: ${missing_deps[*]}"
        print_warning "Please install: sudo pacman -S wl-screenshot grim imagemagick wl-copy"
        return 1
    fi
    
    return 0
}

# Get screenshot tool
get_screenshot_tool() {
    if command -v wl-screenshot > /dev/null; then
        echo "wl-screenshot"
    elif command -v grim > /dev/null; then
        echo "grim"
    else
        echo ""
    fi
}

# Get clipboard tool
get_clipboard_tool() {
    if command -v wl-copy > /dev/null; then
        echo "wl-copy"
    elif command -v xclip > /dev/null; then
        echo "xclip"
    else
        echo ""
    fi
}

# Capture screenshot with retry mechanism
capture_screenshot() {
    local tool="$1"
    local output_file="$2"
    local args="$3"
    
    for ((i=1; i<=MAX_RETRIES; i++)); do
        if [ "$tool" = "wl-screenshot" ]; then
            if wl-screenshot $args -f "$output_file" 2>/dev/null; then
                return 0
            fi
        elif [ "$tool" = "grim" ]; then
            if grim $args "$output_file" 2>/dev/null; then
                return 0
            fi
        fi
        
        if [ $i -lt $MAX_RETRIES ]; then
            print_warning "Screenshot attempt $i failed, retrying..."
            sleep 0.5
        fi
    done
    
    return 1
}

# Capture area selection
capture_area() {
    local tool="$1"
    local output_file="$2"
    local frozen="$3"
    
    print_step "Select area to capture..."
    
    if [ "$frozen" = "true" ]; then
        print_step "Freezing screen for selection..."
        hyprctl dispatch dpms off
        sleep 0.1
        hyprctl dispatch dpms on
    fi
    
    if [ "$tool" = "wl-screenshot" ]; then
        if wl-screenshot -g -f "$output_file" 2>/dev/null; then
            return 0
        fi
    elif [ "$tool" = "grim" ]; then
        if grim -g "$(slurp)" "$output_file" 2>/dev/null; then
            return 0
        fi
    fi
    
    return 1
}

# Capture monitor
capture_monitor() {
    local tool="$1"
    local output_file="$2"
    local monitor="$3"
    
    print_step "Capturing monitor: $monitor"
    
    if [ "$tool" = "wl-screenshot" ]; then
        if wl-screenshot -o "$monitor" -f "$output_file" 2>/dev/null; then
            return 0
        fi
    elif [ "$tool" = "grim" ]; then
        if grim -o "$monitor" "$output_file" 2>/dev/null; then
            return 0
        fi
    fi
    
    return 1
}

# Capture all monitors
capture_all_monitors() {
    local tool="$1"
    local output_file="$2"
    
    print_step "Capturing all monitors"
    
    if [ "$tool" = "wl-screenshot" ]; then
        if wl-screenshot -f "$output_file" 2>/dev/null; then
            return 0
        fi
    elif [ "$tool" = "grim" ]; then
        if grim "$output_file" 2>/dev/null; then
            return 0
        fi
    fi
    
    return 1
}

# Copy to clipboard
copy_to_clipboard() {
    local file="$1"
    local clipboard_tool="$2"
    
    if [ "$clipboard_tool" = "wl-copy" ]; then
        wl-copy < "$file"
    elif [ "$clipboard_tool" = "xclip" ]; then
        xclip -selection clipboard -t image/png < "$file"
    fi
}

# Optimize image for sharing
optimize_image() {
    local input_file="$1"
    local output_file="$2"
    
    # Create optimized version for sharing
    convert "$input_file" \
        -strip \
        -quality 85 \
        -resize 1920x1080\> \
        "$output_file"
}

# Main screenshot function
take_screenshot() {
    local mode="$1"
    local tool=$(get_screenshot_tool)
    local clipboard_tool=$(get_clipboard_tool)
    local timestamp=$(date +"$DATE_FORMAT")
    local filename="screenshot_${timestamp}.png"
    local filepath="$SCREENSHOT_DIR/$filename"
    local optimized_filepath="$SCREENSHOT_DIR/optimized_${filename}"
    
    # Check dependencies
    if ! check_dependencies; then
        exit 1
    fi
    
    if [ -z "$tool" ]; then
        print_error "No screenshot tool available"
        exit 1
    fi
    
    case "$mode" in
        "s"|"select")
            # Area selection
            if capture_area "$tool" "$filepath" "false"; then
                print_success "Area captured successfully"
                send_notification "normal" "Screenshot Captured" "Area selection saved to clipboard" "camera"
                
                # Copy to clipboard
                if [ -n "$clipboard_tool" ]; then
                    copy_to_clipboard "$filepath" "$clipboard_tool"
                    print_success "Screenshot copied to clipboard"
                fi
                
                # Create optimized version
                optimize_image "$filepath" "$optimized_filepath"
                
                return 0
            else
                print_error "Failed to capture area"
                send_notification "critical" "Screenshot Failed" "Failed to capture selected area" "error"
                return 1
            fi
            ;;
            
        "sf"|"select-frozen")
            # Frozen area selection
            if capture_area "$tool" "$filepath" "true"; then
                print_success "Frozen area captured successfully"
                send_notification "normal" "Screenshot Captured" "Frozen area selection saved" "camera"
                
                # Copy to clipboard
                if [ -n "$clipboard_tool" ]; then
                    copy_to_clipboard "$filepath" "$clipboard_tool"
                    print_success "Screenshot copied to clipboard"
                fi
                
                return 0
            else
                print_error "Failed to capture frozen area"
                send_notification "critical" "Screenshot Failed" "Failed to capture frozen area" "error"
                return 1
            fi
            ;;
            
        "m"|"monitor")
            # Current monitor
            local current_monitor=$(hyprctl -j monitors | jq -r '.[] | select(.focused==true) | .name')
            if [ -z "$current_monitor" ]; then
                current_monitor="DP-1"  # fallback
            fi
            
            if capture_monitor "$tool" "$filepath" "$current_monitor"; then
                print_success "Monitor captured successfully"
                send_notification "normal" "Screenshot Captured" "Current monitor saved" "camera"
                
                # Copy to clipboard
                if [ -n "$clipboard_tool" ]; then
                    copy_to_clipboard "$filepath" "$clipboard_tool"
                    print_success "Screenshot copied to clipboard"
                fi
                
                return 0
            else
                print_error "Failed to capture monitor"
                send_notification "critical" "Screenshot Failed" "Failed to capture monitor" "error"
                return 1
            fi
            ;;
            
        "p"|"all")
            # All monitors
            if capture_all_monitors "$tool" "$filepath"; then
                print_success "All monitors captured successfully"
                send_notification "normal" "Screenshot Captured" "All monitors saved" "camera"
                
                # Copy to clipboard
                if [ -n "$clipboard_tool" ]; then
                    copy_to_clipboard "$filepath" "$clipboard_tool"
                    print_success "Screenshot copied to clipboard"
                fi
                
                return 0
            else
                print_error "Failed to capture all monitors"
                send_notification "critical" "Screenshot Failed" "Failed to capture all monitors" "error"
                return 1
            fi
            ;;
            
        "w"|"window")
            # Active window
            print_step "Capturing active window..."
            if [ "$tool" = "wl-screenshot" ]; then
                if wl-screenshot -w -f "$filepath" 2>/dev/null; then
                    print_success "Active window captured successfully"
                    send_notification "normal" "Screenshot Captured" "Active window saved" "camera"
                    
                    # Copy to clipboard
                    if [ -n "$clipboard_tool" ]; then
                        copy_to_clipboard "$filepath" "$clipboard_tool"
                        print_success "Screenshot copied to clipboard"
                    fi
                    
                    return 0
                fi
            else
                print_warning "Window capture not supported with grim, falling back to area selection"
                take_screenshot "s"
                return $?
            fi
            ;;
            
        "c"|"clipboard")
            # Capture and copy to clipboard only
            local temp_file="$TEMP_DIR/screenshot_$(date +%s).png"
            
            if capture_all_monitors "$tool" "$temp_file"; then
                if [ -n "$clipboard_tool" ]; then
                    copy_to_clipboard "$temp_file" "$clipboard_tool"
                    print_success "Screenshot copied to clipboard"
                    send_notification "low" "Screenshot Copied" "Screenshot copied to clipboard" "clipboard"
                    rm -f "$temp_file"
                    return 0
                else
                    print_error "No clipboard tool available"
                    return 1
                fi
            else
                print_error "Failed to capture screenshot"
                return 1
            fi
            ;;
            
        "v"|"video")
            # Screen recording (if supported)
            print_step "Starting screen recording..."
            local video_file="$SCREENSHOT_DIR/screen_record_${timestamp}.mp4"
            
            if command -v wf-recorder > /dev/null; then
                # Start recording
                wf-recorder -f "$video_file" &
                local recorder_pid=$!
                
                send_notification "normal" "Recording Started" "Press Ctrl+C to stop recording" "video"
                
                # Wait for user to stop
                trap "kill $recorder_pid 2>/dev/null; exit" INT
                wait $recorder_pid
                
                print_success "Screen recording saved"
                send_notification "normal" "Recording Saved" "Screen recording completed" "video"
                return 0
            else
                print_error "wf-recorder not available for video recording"
                send_notification "critical" "Recording Failed" "wf-recorder not installed" "error"
                return 1
            fi
            ;;
            
        *)
            print_error "Unknown mode: $mode"
            show_help
            return 1
            ;;
    esac
}

# Show help
show_help() {
    echo "Enhanced Screenshot Script for Hyprland"
    echo ""
    echo "Usage: $0 [MODE]"
    echo ""
    echo "Modes:"
    echo "  s, select        - Capture selected area"
    echo "  sf, select-frozen - Capture selected area (frozen screen)"
    echo "  m, monitor       - Capture current monitor"
    echo "  p, all           - Capture all monitors"
    echo "  w, window        - Capture active window"
    echo "  c, clipboard     - Capture and copy to clipboard only"
    echo "  v, video         - Start screen recording"
    echo ""
    echo "Examples:"
    echo "  $0 s             # Capture area selection"
    echo "  $0 m             # Capture current monitor"
    echo "  $0 c             # Capture and copy to clipboard"
    echo ""
    echo "Files are saved to: $SCREENSHOT_DIR"
}

# Main script
if [ $# -eq 0 ]; then
    show_help
    exit 1
fi

take_screenshot "$1" 