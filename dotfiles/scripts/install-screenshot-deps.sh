#!/bin/bash

# Install Screenshot and Notification Dependencies for Hyprland
# Enhanced setup script for screenshot and notification features

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

# Detect package manager
detect_package_manager() {
    if command -v pacman > /dev/null; then
        echo "pacman"
    elif command -v apt > /dev/null; then
        echo "apt"
    elif command -v dnf > /dev/null; then
        echo "dnf"
    elif command -v yum > /dev/null; then
        echo "yum"
    elif command -v zypper > /dev/null; then
        echo "zypper"
    else
        echo "unknown"
    fi
}

# Install packages based on package manager
install_packages() {
    local pkg_manager="$1"
    local packages=("$2")
    
    case "$pkg_manager" in
        "pacman")
            print_step "Installing packages with pacman..."
            sudo pacman -S --needed --noconfirm "${packages[@]}"
            ;;
        "apt")
            print_step "Installing packages with apt..."
            sudo apt update
            sudo apt install -y "${packages[@]}"
            ;;
        "dnf")
            print_step "Installing packages with dnf..."
            sudo dnf install -y "${packages[@]}"
            ;;
        "yum")
            print_step "Installing packages with yum..."
            sudo yum install -y "${packages[@]}"
            ;;
        "zypper")
            print_step "Installing packages with zypper..."
            sudo zypper install -y "${packages[@]}"
            ;;
        *)
            print_error "Unsupported package manager: $pkg_manager"
            return 1
            ;;
    esac
}

# Install screenshot dependencies
install_screenshot_deps() {
    local pkg_manager=$(detect_package_manager)
    
    print_step "Installing screenshot dependencies..."
    
    # Core screenshot tools
    local screenshot_packages=(
        "wl-screenshot"
        "grim"
        "slurp"
        "imagemagick"
        "wl-copy"
        "xclip"
    )
    
    install_packages "$pkg_manager" "${screenshot_packages[*]}"
    
    # Optional: Screen recording
    if [ "$pkg_manager" = "pacman" ]; then
        print_step "Installing screen recording tools..."
        sudo pacman -S --needed --noconfirm wf-recorder
    fi
    
    print_success "Screenshot dependencies installed"
}

# Install notification dependencies
install_notification_deps() {
    local pkg_manager=$(detect_package_manager)
    
    print_step "Installing notification dependencies..."
    
    # Core notification tools
    local notification_packages=(
        "mako"
        "libnotify"
        "jq"
    )
    
    install_packages "$pkg_manager" "${notification_packages[*]}"
    
    print_success "Notification dependencies installed"
}

# Install additional utilities
install_utilities() {
    local pkg_manager=$(detect_package_manager)
    
    print_step "Installing additional utilities..."
    
    # Color picker and utilities
    local utility_packages=(
        "hyprpicker"
        "jq"
        "bc"
    )
    
    install_packages "$pkg_manager" "${utility_packages[*]}"
    
    print_success "Utilities installed"
}

# Setup directories and permissions
setup_directories() {
    print_step "Setting up directories..."
    
    # Create screenshot directory
    mkdir -p "$HOME/Pictures/Screenshots"
    
    # Create notification config directory
    mkdir -p "$HOME/.config/notification-manager"
    
    # Set permissions
    chmod 755 "$HOME/Pictures/Screenshots"
    chmod 755 "$HOME/.config/notification-manager"
    
    print_success "Directories set up"
}

# Test installation
test_installation() {
    print_step "Testing installation..."
    
    # Test screenshot tools
    if command -v wl-screenshot > /dev/null || command -v grim > /dev/null; then
        print_success "Screenshot tools available"
    else
        print_error "Screenshot tools not found"
        return 1
    fi
    
    # Test notification tools
    if command -v mako > /dev/null; then
        print_success "Notification tools available"
    else
        print_error "Notification tools not found"
        return 1
    fi
    
    # Test utilities
    if command -v hyprpicker > /dev/null; then
        print_success "Color picker available"
    else
        print_warning "Color picker not found"
    fi
    
    if command -v jq > /dev/null; then
        print_success "JSON processor available"
    else
        print_warning "JSON processor not found"
    fi
    
    print_success "Installation test completed"
}

# Show usage information
show_usage() {
    echo "Enhanced Screenshot and Notification Setup"
    echo ""
    echo "This script installs all dependencies needed for:"
    echo "  - Enhanced screenshot functionality"
    echo "  - Advanced notification management"
    echo "  - Screen recording capabilities"
    echo "  - Color picking and clipboard integration"
    echo ""
    echo "Usage: $0 [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  --screenshot-only  - Install only screenshot dependencies"
    echo "  --notification-only - Install only notification dependencies"
    echo "  --test             - Test installation without installing"
    echo "  --help             - Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0                 # Install all dependencies"
    echo "  $0 --screenshot-only # Install only screenshot tools"
    echo "  $0 --test          # Test current installation"
}

# Main script
main() {
    case "${1:-}" in
        "--screenshot-only")
            install_screenshot_deps
            setup_directories
            test_installation
            ;;
        "--notification-only")
            install_notification_deps
            setup_directories
            test_installation
            ;;
        "--test")
            test_installation
            ;;
        "--help"|"-h"|"help")
            show_usage
            ;;
        "")
            # Install everything
            install_screenshot_deps
            install_notification_deps
            install_utilities
            setup_directories
            test_installation
            
            print_success "Installation completed successfully!"
            echo ""
            echo "Available keybindings:"
            echo "  Super + P          - Capture area selection"
            echo "  Super + Ctrl + P   - Capture frozen area"
            echo "  Super + Alt + P    - Capture current monitor"
            echo "  Print              - Capture all monitors"
            echo "  Super + Shift + C  - Capture to clipboard"
            echo "  Super + Alt + W    - Capture active window"
            echo "  Super + Ctrl + V   - Start screen recording"
            echo ""
            echo "Notification controls:"
            echo "  Super + N          - Toggle Do Not Disturb"
            echo "  Super + Shift + N  - Test notifications"
            echo "  Super + Ctrl + N   - Clear all notifications"
            echo "  Super + Alt + N    - Show notification history"
            ;;
        *)
            print_error "Unknown option: $1"
            show_usage
            exit 1
            ;;
    esac
}

# Run main function
main "$@" 