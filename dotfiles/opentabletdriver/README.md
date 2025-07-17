# OpenTabletDriver Integration for Arch Linux + Hyprland

## 🎨 Overview

This configuration provides complete integration of OpenTabletDriver with Arch Linux and Hyprland, ensuring automatic detection and configuration of graphics tablets on system startup.

## ✨ Features

- **Automatic Startup**: OpenTabletDriver starts automatically on login
- **Auto-Detection**: Automatically detects and configures compatible tablets
- **Wayland Support**: Full compatibility with Wayland and Hyprland
- **Easy Configuration**: Simple GUI access and configuration management
- **Persistent Settings**: Configuration saved in `~/.config/OpenTabletDriver/`
- **UDEV Rules**: Proper device permissions and hotplug support

## 🚀 Quick Installation

### 1. Install OpenTabletDriver

```bash
# Install from AUR
yay -S opentabletdriver-bin

# Or install from source
git clone https://github.com/OpenTabletDriver/OpenTabletDriver.git
cd OpenTabletDriver
make
sudo make install
```

### 2. Install Integration Files

```bash
# Copy integration files
cp -r dotfiles/opentabletdriver/* ~/.config/

# Make scripts executable
chmod +x ~/.config/opentabletdriver/scripts/*.sh

# Install systemd user service
systemctl --user enable opentabletdriver.service
systemctl --user start opentabletdriver.service
```

### 3. Install UDEV Rules (if needed)

```bash
# Copy UDEV rules
sudo cp dotfiles/opentabletdriver/udev/99opentabletdriver.rules /etc/udev/rules.d/

# Reload UDEV rules
sudo udevadm control --reload-rules
sudo udevadm trigger
```

## 📁 File Structure

```
~/.config/opentabletdriver/
├── config/
│   ├── default.json          # Default tablet configuration
│   └── profiles/             # User profiles
├── scripts/
│   ├── start-driver.sh       # Driver startup script
│   ├── detect-tablets.sh     # Tablet detection script
│   ├── configure-tablet.sh   # Tablet configuration script
│   └── gui-launcher.sh       # GUI launcher script
├── systemd/
│   └── opentabletdriver.service  # Systemd user service
└── autostart/
    └── opentabletdriver.desktop  # Hyprland autostart entry
```

## 🔧 Configuration

### Default Configuration

The default configuration is located at `~/.config/opentabletdriver/config/default.json` and includes:

- **Pen Pressure**: 2048 levels of pressure sensitivity
- **Pen Buttons**: Standard pen button mapping
- **Tablet Buttons**: ExpressKeys configuration
- **Screen Mapping**: Full screen mapping
- **Relative Mode**: Enabled for better compatibility

### Customizing Configuration
1dit Default Config**:
   ```bash
   nano ~/.config/opentabletdriver/config/default.json
   ```

2te Custom Profiles**:
   ```bash
   cp ~/.config/opentabletdriver/config/default.json ~/.config/opentabletdriver/config/profiles/my-profile.json
   ```

3. **Use GUI Configuration**:
   ```bash
   opentabletdriver-gui
   ```

## 🎮 Usage

### Starting the Driver

The driver starts automatically on login, but you can also:

```bash
# Start manually
systemctl --user start opentabletdriver

# Stop manually
systemctl --user stop opentabletdriver

# Check status
systemctl --user status opentabletdriver

# View logs
journalctl --user -u opentabletdriver -f
```

### Opening GUI Configuration

```bash
# Method 1 Direct command
opentabletdriver-gui

# Method2ng launcher script
~/.config/opentabletdriver/scripts/gui-launcher.sh

# Method 3: From application menu
# Search for OpenTabletDriver" in your app launcher
```

### Detecting Tablets

```bash
# List detected tablets
~/.config/opentabletdriver/scripts/detect-tablets.sh

# Configure specific tablet
~/.config/opentabletdriver/scripts/configure-tablet.sh
```

## 🔍 Troubleshooting

### Common Issues

1. **Driver not starting**:
   ```bash
   # Check if service is enabled
   systemctl --user is-enabled opentabletdriver
   
   # Check logs
   journalctl --user -u opentabletdriver -n 50
   ```

2. **Tablet not detected**:
   ```bash
   # Check UDEV rules
   lsusb | grep -i tablet
   
   # Check device permissions
   ls -la /dev/input/event*
   ```

3. **Wayland compatibility issues**:
   ```bash
   # Ensure proper environment variables
   echo $XDG_SESSION_TYPE
   
   # Check if running under Wayland
   loginctl show-session $XDG_SESSION_ID -p Type
   ```

### Debug Mode

Enable debug logging:

```bash
# Edit service file
nano ~/.config/opentabletdriver/systemd/opentabletdriver.service

# Add debug flags to ExecStart
ExecStart=/usr/bin/OpenTabletDriver --verbose

# Reload and restart
systemctl --user daemon-reload
systemctl --user restart opentabletdriver
```

## 📋 Supported Tablets

This configuration supports most tablets including:

- **Wacom**: Intuos, Cintiq, Bamboo, etc.
- **Huion**: H610, H950P, Inspiroy, etc.
- **XP-Pen**: Artist, Deco, Star, etc.
- **Gaomon**: PD, S, etc.
- **Veikk**: A15 A30, etc.
- **And more...**

## 🎯 Advanced Configuration

### Custom Button Mapping

Edit `~/.config/opentabletdriver/config/default.json`:

```json
[object Object]Pen": {
    Tip":Button1, Eraser: Button3"
  },
 AuxiliaryButtons": [object Object]   Button1": Key",
    Button2": Key",
    Button3":Key"
  }
}
```

### Screen Mapping

Configure screen mapping in the GUI or edit config:

```json[object Object]OutputMode: Absolute,
  Area":[object Object]
    X:0
    Y: 0,
    Width":1920
  Height": 180
```

### Pressure Sensitivity

Adjust pressure sensitivity:

```json
{
  "TipActivationPressure": 0.1,
  "TipActivationPressureRange": 0.1
}
```

## 🔄 Updates

To update the integration:

```bash
# Update OpenTabletDriver
yay -Syu opentabletdriver-bin

# Update integration files
cp -r dotfiles/opentabletdriver/* ~/.config/

# Restart service
systemctl --user restart opentabletdriver
```

## 📚 Additional Resources

- [OpenTabletDriver GitHub](https://github.com/OpenTabletDriver/OpenTabletDriver)
- [OpenTabletDriver Wiki](https://github.com/OpenTabletDriver/OpenTabletDriver/wiki)
- [Arch Linux Wiki - Graphics Tablet](https://wiki.archlinux.org/title/Graphics_tablet)
- [Hyprland Wiki](https://wiki.hyprland.org/)

## 🤝 Contributing

Feel free to submit issues and enhancement requests for the integration.

---

**Enjoy your graphics tablet with OpenTabletDriver! 🎨** 