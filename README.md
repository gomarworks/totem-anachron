# Totem Keyboard with Anachron Layout

This is an implementation of [theol0403's Anachron layout](https://github.com/theol0403/anachron-zmk-config) for the Totem keyboard. Anachron is a 34-key layout designed for speed and efficiency.

## Features

- Base layer using the Graphite alpha layout
- Navigation and number pad on NAV layer
- Symbols and special characters on SYM layer
- System functions and Bluetooth controls on ADJ layer
- Smart sticky modifiers and layers
- Combo-based functionality for quick access

## Layout

### Base Layer
```
╭─────────────────────┬─────────────────────╮
│ Q  W  F  P  G      │      J  L  U  Y  ;  │
│ A  R  S  T  D      │      H  N  E  I  O  │
│ Z  X  C  V  B      │      K  M  ,  .  /  │
╰───────╮ TAB SPC RET │ BSPC ╭───────╯
        ╰─────────────┴─────────╯
```

### Navigation Layer (NAV)
```
╭─────────────────────┬─────────────────────╮
│ ESC  BT_CLR UP  =   │ {  }  7  8  9  +   │
│ SHFT ←     ↓   →   │ [  ]  4  5  6  -   │
│ _    DEL   PGUP CAPS│ (  )  1  2  3  *   │
╰───────╮ _   _   ADJ │ 0   ╭───────╯
        ╰─────────────┴─────────╯
```

### Symbol Layer (SYM)
```
╭─────────────────────┬─────────────────────╮
│ !  @  #  $  %      │      ^  &  Ü  '  "  │
│ Á  _  ß  _  _      │ MUTE _  _  _  _  Ó  │
│ _  _  _  _  _      │      _  _  _  _  _  │
╰───────╮ _   _   ADJ │ _    ╭───────╯
        ╰─────────────┴─────────╯
```

## Credits

- Original Anachron layout by [@theol0403](https://github.com/theol0403)
- Inspired by [urob](https://github.com/urob), [callum](https://github.com/callum-oakley), and [seniply](https://github.com/seniply)

## Building

1. Make sure you have the ZMK environment set up
2. Clone this repository
3. Run `west build -b xiao_ble -- -DSHIELD=totem_left` for the left half
4. Run `west build -b xiao_ble -- -DSHIELD=totem_right` for the right half
5. Flash the resulting firmware files to your Totem keyboard

## License

This project is licensed under the MIT License - see the LICENSE file for details. 