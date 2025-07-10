# Catppuccin SDDM Theme

This directory contains instructions to install and configure the Catppuccin theme for SDDM.

## Quick Installation

1. Clone the official repository:

   ```bash
   git clone https://github.com/catppuccin/sddm.git /tmp/catppuccin-sddm
   ```

2. Copy your preferred flavor (e.g., "mocha") to the SDDM themes directory:

   ```bash
   sudo cp -r /tmp/catppuccin-sddm/src/mocha /usr/share/sddm/themes/
   ```

3. Edit (or create) the SDDM config file `/etc/sddm.conf` and add or update:

   ```ini
   [Theme]
   Current=mocha
   ```

4. Restart SDDM or your PC to apply the new theme.

### Extra: Set a custom background

To set a custom background, edit `/usr/share/sddm/themes/mocha/theme.conf` and set the `Background` option to your image path.

For more details and customization, visit: [https://github.com/catppuccin/sddm](https://github.com/catppuccin/sddm)
