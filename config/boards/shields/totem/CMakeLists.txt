# SPDX-License-Identifier: MIT

zephyr_library()
zephyr_library_sources(totem.dtsi)
zephyr_library_sources_ifdef(CONFIG_SHIELD_TOTEM_LEFT totem_left.overlay)
zephyr_library_sources_ifdef(CONFIG_SHIELD_TOTEM_RIGHT totem_right.overlay) 