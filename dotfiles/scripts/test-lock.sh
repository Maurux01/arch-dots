#!/bin/bash

# Test script for hyprlock with logging
# This script helps debug hyprlock issues

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOG_FILE="$HOME/.cache/hyprlock-test.log"

# Create log directory if it doesn't exist
mkdir -p "$(dirname "$LOG_FILE")"

echo "=== Hyprlock Test Script ===" | tee "$LOG_FILE"
echo "Date: $(date)" | tee -a "$LOG_FILE"
echo "User: $USER" | tee -a "$LOG_FILE"
echo "Display: $DISPLAY" | tee -a "$LOG_FILE"
echo "Wayland Display: $WAYLAND_DISPLAY" | tee -a "$LOG_FILE"
echo "" | tee -a "$LOG_FILE"

# Check if hyprlock is installed
echo "Checking hyprlock installation..." | tee -a "$LOG_FILE"
if command -v hyprlock >/dev/null 2>&1; then
    echo "✓ hyprlock is installed" | tee -a "$LOG_FILE"
    hyprlock --version | tee -a "$LOG_FILE"
else
    echo "✗ hyprlock is not installed" | tee -a "$LOG_FILE"
    echo "Please install hyprlock: sudo pacman -S hyprlock" | tee -a "$LOG_FILE"
    exit 1
fi

echo "" | tee -a "$LOG_FILE"

# Check hyprlock configuration
echo "Checking hyprlock configuration..." | tee -a "$LOG_FILE"
CONFIG_FILE="$HOME/.config/hypr/hyprlock.conf"
if [ -f "$CONFIG_FILE" ]; then
    echo "✓ Configuration file found: $CONFIG_FILE" | tee -a "$LOG_FILE"
    echo "Configuration file size: $(wc -l < "$CONFIG_FILE") lines" | tee -a "$LOG_FILE"
else
    echo "✗ Configuration file not found: $CONFIG_FILE" | tee -a "$LOG_FILE"
fi

echo "" | tee -a "$LOG_FILE"

# Check if running under Hyprland
echo "Checking Hyprland environment..." | tee -a "$LOG_FILE"
if [ -n "$HYPRLAND_INSTANCE_SIGNATURE" ]; then
    echo "✓ Running under Hyprland" | tee -a "$LOG_FILE"
    echo "Instance: $HYPRLAND_INSTANCE_SIGNATURE" | tee -a "$LOG_FILE"
else
    echo "⚠ Not running under Hyprland" | tee -a "$LOG_FILE"
fi

echo "" | tee -a "$LOG_FILE"

# Check monitors
echo "Checking monitors..." | tee -a "$LOG_FILE"
if command -v hyprctl >/dev/null 2>&1; then
    echo "Active monitors:" | tee -a "$LOG_FILE"
    hyprctl monitors | tee -a "$LOG_FILE"
else
    echo "⚠ hyprctl not available" | tee -a "$LOG_FILE"
fi

echo "" | tee -a "$LOG_FILE"

# Test hyprlock with verbose output
echo "Testing hyprlock..." | tee -a "$LOG_FILE"
echo "Starting hyprlock test in 3 seconds..." | tee -a "$LOG_FILE"
echo "Press Ctrl+C to cancel" | tee -a "$LOG_FILE"
echo "" | tee -a "$LOG_FILE"

sleep 3

# Run hyprlock with logging
echo "Executing: hyprlock --immediate" | tee -a "$LOG_FILE"
echo "Log file: $LOG_FILE" | tee -a "$LOG_FILE"
echo "" | tee -a "$LOG_FILE"

# Run hyprlock and capture any error output
if hyprlock --immediate 2>&1 | tee -a "$LOG_FILE"; then
    echo "" | tee -a "$LOG_FILE"
    echo "✓ Hyprlock executed successfully" | tee -a "$LOG_FILE"
else
    echo "" | tee -a "$LOG_FILE"
    echo "✗ Hyprlock failed to execute" | tee -a "$LOG_FILE"
    echo "Check the log file for details: $LOG_FILE" | tee -a "$LOG_FILE"
fi

echo "" | tee -a "$LOG_FILE"
echo "Test completed. Log saved to: $LOG_FILE" | tee -a "$LOG_FILE" 