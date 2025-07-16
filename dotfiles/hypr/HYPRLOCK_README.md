# Hyprlock Configuration and Troubleshooting

This document provides information about the hyprlock configuration and how to test and troubleshoot issues.

## Configuration Files

### Main Configuration
- **File**: `~/.config/hypr/hyprlock.conf`
- **Purpose**: Main hyprlock configuration with dark background and visible input field
- **Features**:
  - Solid dark background (rgba(26, 27, 38, 0.95))
  - Centered password input field
  - Time display
  - User greeting
  - System info display

### Theme Configuration
- **File**: `~/.config/hypr/hyprlock/theme.conf`
- **Purpose**: Alternative theme configuration
- **Usage**: Can be used as a backup or alternative theme

## Keybind

The lock screen is bound to:
- **Key**: `Super + L`
- **Command**: `hyprlock`
- **Location**: `dotfiles/hypr/keybindings.conf` (line 32)

## Testing Hyprlock

### Quick Test
1. Press `Super + L` to trigger the lock screen
2. Enter your password to unlock
3. If it works, the configuration is correct

### Diagnostic Test
Use the provided test script for detailed diagnostics:

```bash
# Run the test script
./dotfiles/scripts/test-lock.sh
```

The script will:
- Check if hyprlock is installed
- Verify configuration files
- Test hyprlock execution
- Generate a detailed log file

### Manual Testing
```bash
# Test hyprlock directly
hyprlock --immediate

# Test with specific config
hyprlock -c ~/.config/hypr/hyprlock.conf

# Check hyprlock version
hyprlock --version
```

## Troubleshooting

### Common Issues

#### 1. "Oopsie daisy... the lockscreen app died"
**Causes**:
- Missing or incorrect configuration file
- Monitor configuration issues
- Font not found

**Solutions**:
```bash
# Check if hyprlock is installed
pacman -Q hyprlock

# Verify configuration file exists
ls -la ~/.config/hypr/hyprlock.conf

# Check configuration syntax
hyprlock --immediate

# Check available monitors
hyprctl monitors
```

#### 2. Black Screen or No Input Field
**Causes**:
- Monitor configuration mismatch
- Font issues
- Background configuration problems

**Solutions**:
```bash
# Update monitor configuration
# Edit ~/.config/hypr/hyprlock.conf and change:
# monitor = eDP-1
# to your actual monitor name from: hyprctl monitors

# Check font availability
fc-list | grep "JetBrains Mono"

# Test with minimal config
hyprlock -c dotfiles/hypr/hyprlock/theme.conf
```

#### 3. Input Field Not Visible
**Causes**:
- Color configuration issues
- Position problems
- Font size too small

**Solutions**:
```bash
# Check the input-field configuration in hyprlock.conf
# Ensure colors have sufficient contrast
# Verify position values are reasonable
```

### Debugging Steps

1. **Check Installation**:
   ```bash
   pacman -Q hyprlock
   which hyprlock
   ```

2. **Verify Configuration**:
   ```bash
   ls -la ~/.config/hypr/hyprlock.conf
   cat ~/.config/hypr/hyprlock.conf
   ```

3. **Check Environment**:
   ```bash
   echo $HYPRLAND_INSTANCE_SIGNATURE
   echo $WAYLAND_DISPLAY
   ```

4. **Test with Minimal Config**:
   ```bash
   # Create minimal test config
   cat > /tmp/test-hyprlock.conf << EOF
   general {
       disable_loading_bar = false
       grace = 2
       hide_cursor = true
   }
   
   background {
       monitor = eDP-1
       color = rgba(0, 0, 0, 1)
   }
   
   input-field {
       monitor = eDP-1
       size = 200, 50
       position = 0, 0
       halign = center
       valign = center
       outer_color = rgb(0, 0, 0)
       inner_color = rgb(255, 255, 255)
       font_color = rgb(0, 0, 0)
   }
   EOF
   
   hyprlock -c /tmp/test-hyprlock.conf
   ```

5. **Check Logs**:
   ```bash
   # Run test script for detailed logs
   ./dotfiles/scripts/test-lock.sh
   
   # Check the log file
   cat ~/.cache/hyprlock-test.log
   ```

### Monitor Configuration

If you have multiple monitors or different monitor names:

1. **Find your monitor name**:
   ```bash
   hyprctl monitors
   ```

2. **Update configuration**:
   Edit `~/.config/hypr/hyprlock.conf` and change:
   ```
   monitor = eDP-1
   ```
   To your actual monitor name.

3. **Test the change**:
   ```bash
   hyprlock --immediate
   ```

## Installation

If hyprlock is not installed:

```bash
# Install hyprlock
sudo pacman -S hyprlock

# Verify installation
hyprlock --version
```

## Configuration Customization

### Change Background
To use an image background instead of solid color:

```bash
# Edit ~/.config/hypr/hyprlock.conf
# Uncomment and modify the background section:
background {
    monitor = eDP-1
    path = ~/Pictures/wallpapers/sddm-background.jpg
    blur_passes = 3
    blur_size = 8
    noise = 0.0117
    contrast = 0.8916
    brightness = 0.8172
    vibrancy = 0.1696
    vibrancy_darkness = 0.0
}
```

### Change Colors
Modify the color values in the configuration:

```bash
# Input field colors
outer_color = rgb(151515)      # Border color
inner_color = rgb(200, 200, 200)  # Background color
font_color = rgb(10, 10, 10)      # Text color
check_color = rgb(204, 136, 34)   # Success color
fail_color = rgb(204, 34, 34)     # Error color
```

### Change Font
Update the font family in the configuration:

```bash
# Replace "JetBrains Mono" with your preferred font
font_family = Your Font Name
```

## Support

If you continue to have issues:

1. Run the test script: `./dotfiles/scripts/test-lock.sh`
2. Check the log file: `cat ~/.cache/hyprlock-test.log`
3. Verify your monitor configuration
4. Test with the minimal theme configuration
5. Check the hyprlock documentation: https://github.com/hyprwm/hyprlock 