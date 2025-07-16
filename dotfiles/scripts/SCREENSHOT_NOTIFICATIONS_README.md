# Enhanced Screenshot and Notification Integration for Hyprland

This document describes the enhanced screenshot and notification features integrated into the Hyprland configuration.

## 🖼️ Enhanced Screenshot Features

### Screenshot Script (`screenshot.sh`)

A comprehensive screenshot script with multiple capture modes, notifications, and clipboard integration.

#### Features:
- **Multiple capture modes**: Area selection, monitor capture, window capture, all monitors
- **Clipboard integration**: Automatic copying to clipboard
- **Retry mechanism**: Handles capture failures gracefully
- **Image optimization**: Creates optimized versions for sharing
- **Screen recording**: Video capture support
- **Notifications**: Success/failure notifications for all operations

#### Capture Modes:
- `s` / `select` - Capture selected area
- `sf` / `select-frozen` - Capture selected area (frozen screen)
- `m` / `monitor` - Capture current monitor
- `p` / `all` - Capture all monitors
- `w` / `window` - Capture active window
- `c` / `clipboard` - Capture and copy to clipboard only
- `v` / `video` - Start screen recording

#### Keybindings:
- `Super + P` - Capture area selection
- `Super + Ctrl + P` - Capture frozen area
- `Super + Alt + P` - Capture current monitor
- `Print` - Capture all monitors
- `Super + Shift + C` - Capture to clipboard
- `Super + Alt + W` - Capture active window
- `Super + Ctrl + V` - Start screen recording

## 🔔 Enhanced Notification Features

### Notification Manager (`notification-manager.sh`)

Advanced notification management with Do Not Disturb, scheduling, and filtering capabilities.

#### Features:
- **Do Not Disturb**: Toggle notification blocking
- **Notification filtering**: Filter unwanted notifications
- **Scheduling**: Time-based notification rules
- **History**: Track notification history
- **Statistics**: Notification usage analytics
- **Testing**: Comprehensive notification testing

#### Keybindings:
- `Super + N` - Toggle Do Not Disturb
- `Super + Shift + N` - Test notifications
- `Super + Ctrl + N` - Clear all notifications
- `Super + Alt + N` - Show notification history

#### Commands:
```bash
# Basic controls
notification-manager.sh start/stop/restart
notification-manager.sh test
notification-manager.sh dnd

# History and statistics
notification-manager.sh history [limit]
notification-manager.sh stats

# Filtering
notification-manager.sh filter add <pattern>
notification-manager.sh filter remove <pattern>
notification-manager.sh filter list

# Scheduling
notification-manager.sh schedule add <day> <start> <end>
notification-manager.sh schedule remove <pattern>
notification-manager.sh schedule list
```

## 📦 Installation

### Automatic Installation

Run the installation script to install all dependencies:

```bash
./dotfiles/scripts/install-screenshot-deps.sh
```

### Manual Installation

Install the required packages:

```bash
# Screenshot tools
sudo pacman -S wl-screenshot grim slurp imagemagick wl-copy xclip

# Notification tools
sudo pacman -S mako libnotify jq

# Additional utilities
sudo pacman -S hyprpicker bc

# Screen recording (optional)
sudo pacman -S wf-recorder
```

## ⚙️ Configuration

### Screenshot Configuration

The screenshot script automatically:
- Creates `~/Pictures/Screenshots/` directory
- Saves screenshots with timestamped filenames
- Creates optimized versions for sharing
- Copies to clipboard automatically

### Notification Configuration

The notification manager creates:
- `~/.config/notification-manager/` directory
- Configuration files for filters, schedules, and history
- Automatic Do Not Disturb status tracking

### Mako Configuration

Enhanced mako configuration includes:
- App-specific notification styling
- Screenshot and recording notifications
- Better interaction handling
- Improved grouping and management

## 🎯 Usage Examples

### Screenshot Examples

```bash
# Capture area selection
screenshot.sh s

# Capture current monitor
screenshot.sh m

# Capture and copy to clipboard
screenshot.sh c

# Start screen recording
screenshot.sh v
```

### Notification Examples

```bash
# Toggle Do Not Disturb
notification-manager.sh dnd

# Test notifications
notification-manager.sh test

# Filter spam notifications
notification-manager.sh filter add "spam"

# Set notification schedule (9AM-6PM daily)
notification-manager.sh schedule add all 9 18

# Show recent notifications
notification-manager.sh history 20
```

## 🔧 Advanced Features

### Screenshot Features

1. **Retry Mechanism**: Automatically retries failed captures
2. **Tool Detection**: Supports both `wl-screenshot` and `grim`
3. **Clipboard Integration**: Works with `wl-copy` and `xclip`
4. **Image Optimization**: Creates web-friendly versions
5. **Error Handling**: Comprehensive error reporting

### Notification Features

1. **Do Not Disturb**: Complete notification blocking
2. **Smart Filtering**: Regex-based notification filtering
3. **Time Scheduling**: Hour-based notification rules
4. **History Tracking**: Persistent notification logs
5. **Statistics**: Usage analytics and reporting

## 🐛 Troubleshooting

### Common Issues

1. **Screenshot not working**:
   - Check if `wl-screenshot` or `grim` is installed
   - Verify Wayland session is active
   - Check permissions for screenshot directory

2. **Notifications not showing**:
   - Ensure `mako` is running: `pgrep mako`
   - Check mako configuration: `~/.config/mako/config`
   - Verify `libnotify` is installed

3. **Clipboard not working**:
   - Install `wl-copy` for Wayland
   - Install `xclip` for X11 fallback
   - Check clipboard permissions

### Debug Commands

```bash
# Test screenshot tools
screenshot.sh --help

# Test notification system
notification-manager.sh test

# Check mako status
notification-manager.sh status

# View notification history
notification-manager.sh history
```

## 📝 File Structure

```
dotfiles/scripts/
├── screenshot.sh                    # Enhanced screenshot script
├── notification-manager.sh          # Notification management
├── install-screenshot-deps.sh      # Installation script
└── mako-control.sh                 # Basic mako control

dotfiles/mako/
└── config                          # Enhanced mako configuration

dotfiles/hypr/
└── keybindings.conf               # Updated keybindings
```

## 🔄 Integration with Existing System

The new features integrate seamlessly with the existing Hyprland setup:

- **Keybindings**: Added to existing keybinding structure
- **Notifications**: Enhanced mako configuration
- **Scripts**: Follow existing script patterns
- **Documentation**: Consistent with project style

## 🚀 Future Enhancements

Planned improvements:
- OCR integration for screenshot text extraction
- Cloud backup for screenshots
- Advanced notification rules
- Screenshot annotation tools
- Video editing capabilities

## 📞 Support

For issues or questions:
1. Check the troubleshooting section
2. Review the script help: `./script.sh --help`
3. Check system logs for errors
4. Verify all dependencies are installed

---

**Note**: These features require a Wayland session and Hyprland window manager. Some features may not work in X11 sessions. 