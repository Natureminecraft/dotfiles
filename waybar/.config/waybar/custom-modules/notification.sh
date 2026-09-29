#!/usr/bin/env bash
# Waybar custom module for swaync DND status

DND_STATE=$(swaync-client -D 2>/dev/null | tr -d '[:space:]')
COUNT=$(swaync-client -c 2>/dev/null | tr -d '[:space:]')

if [[ "$DND_STATE" == "true" ]]; then
    ICON="󰂛"
    CLASS="dnd"
    TOOLTIP="Enable"
else
    ICON="󰂚"
    CLASS="normal"
    TOOLTIP="Disable"
fi

printf '{"text": "%s", "tooltip": "%s", "class": "%s", "alt": "%s"}\n' \
  "$ICON" "$TOOLTIP" "$CLASS" "$DND_STATE"
