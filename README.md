# Totem-Anachron Keyboard Firmware

An experimental keyboard firmware that brings the advanced features of the Anachron layout to the Totem keyboard hardware. This project aims to combine the excellent ergonomics of the Totem with the sophisticated key behaviors and layout optimizations from Anachron.

## The Story

The Totem keyboard, designed by [GEIGEIGEIST](https://github.com/GEIGEIGEIST/zmk-config-totem), is a 36-key split keyboard known for its comfortable column-staggered layout and clean design. Meanwhile, [theol0403's Anachron](https://github.com/theol0403/anachron-zmk-config) represents a cutting-edge approach to keyboard layouts, featuring advanced behaviors like smart modifiers, conditional layers, and an innovative combo system.

This project attempts to merge these two worlds: taking the Totem's hardware as a foundation and implementing Anachron's sophisticated features. We're using [theol0403's ZMK fork](https://github.com/theol0403/zmk/tree/local) which includes several unmerged features required for the Anachron layout, and [urob's Nix-based build system](https://github.com/urob/zmk-config) for a reproducible development environment.

## Key Features

- **Smart Layer Management**: Conditional layers that activate based on specific key combinations
- **Advanced Modifiers**: Sticky keys with balanced hold-tap behaviors
- **Innovative Combos**: Extensive combo system for efficient key access
- **Dynamic Macros**: Support for recording and playing back macros
- **Media Controls**: Dedicated media layer with Bluetooth management

## Building

Simply run:
```bash
nix develop
```

Then build with:
```bash
build_split_keyboard
```

## Acknowledgments

This project wouldn't be possible without the work of:
- [GEIGEIGEIST](https://github.com/GEIGEIGEIST) for the Totem keyboard design
- [theol0403](https://github.com/theol0403) for the Anachron layout and features
- [urob](https://github.com/urob) for the Nix-based build system approach

## License

This project is licensed under the MIT License - see the LICENSE file for details. 