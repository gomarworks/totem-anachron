# Totem Anachron Keyboard Configuration

This repository contains the ZMK configuration for the Totem keyboard with an Anachron-inspired keymap. The configuration is based on the [Anachron ZMK Config](https://github.com/anachron/zmk-config) and adapted for the Totem keyboard.

## Features

- Split keyboard configuration for the Totem keyboard
- Anachron-inspired keymap with homerow mods
- Multiple layers for navigation, function keys, numbers, and system controls
- Combo support for common shortcuts
- Leader key sequences for advanced functionality
- Mouse emulation support
- Built-in support for wireless connectivity

## Layers

The keyboard has the following layers:

1. **Base Layer**: Default typing layer with homerow mods
2. **Nav Layer**: Navigation and editing controls
3. **Fn Layer**: Function keys and media controls
4. **Num Layer**: Number pad and symbols
5. **Sys Layer**: System controls and Bluetooth management
6. **Mouse Layer**: Mouse emulation

## Key Features

### Homerow Mods

The homerow keys on the left hand are configured as mods when held:
- A: Left GUI
- R: Left Alt
- S: Left Shift
- T: Left Ctrl

The homerow keys on the right hand are configured as mods when held:
- N: Right Ctrl
- E: Right Shift
- I: Right Alt
- O: Right GUI

### Combos

The configuration includes various combos for common shortcuts:

- **Horizontal Combos**: Quick access to common editing functions
- **Vertical Combos**: Access to symbols and special characters
- **Thumb Combos**: Layer switching and special functions

### Leader Key

The leader key provides access to a wide range of shortcuts and commands. Some examples:

- `leader + q`: Quit application
- `leader + s`: Save
- `leader + n`: New file
- `leader + o`: Open file
- `leader + w`: Close file
- `leader + z`: Undo
- `leader + y`: Redo
- `leader + x`: Cut
- `leader + c`: Copy
- `leader + v`: Paste

### Mouse Emulation

The mouse layer provides full mouse emulation capabilities:

- Arrow keys for mouse movement
- Mouse buttons (left, right, middle)
- Mouse wheel scrolling
- Adjustable mouse speed and acceleration

## Building

To build the firmware:

1. Clone this repository
2. Initialize the ZMK workspace:
   ```bash
   west init -l config
   west update
   ```
3. Build the firmware:
   ```bash
   west build -d build/left -p -b xiao_ble -- -DSHIELD=totem_left
   west build -d build/right -p -b xiao_ble -- -DSHIELD=totem_right
   ```

## Flashing

To flash the firmware to your keyboard:

1. Connect your keyboard in bootloader mode
2. Flash the firmware:
   ```bash
   west flash -d build/left
   west flash -d build/right
   ```

## Customization

You can customize the keymap by editing the following files:

- `config/totem.keymap`: Main keymap configuration
- `config/combos.dtsi`: Combo definitions
- `config/leader.dtsi`: Leader key sequences
- `config/mouse.dtsi`: Mouse emulation settings

## Credits

- [Anachron ZMK Config](https://github.com/anachron/zmk-config) for the base keymap design
- [ZMK Firmware](https://github.com/zmkfirmware/zmk) for the firmware
- [Totem Keyboard](https://github.com/theol0403/totem) for the keyboard design 