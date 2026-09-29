#!/bin/bash

player_status=$(playerctl -p spotify status 2>/dev/null)

if [ "$player_status" = "Playing" ] || [ "$player_status" = "Paused" ]; then
    artist=$(playerctl -p spotify metadata artist 2>/dev/null)
    title=$(playerctl -p spotify metadata title 2>/dev/null)
    text="$artist - $title"

    # Escape for JSON
    text=$(echo "$text" | sed 's/\\/\\\\/g; s/"/\\"/g')

    echo "{\"text\": \"$text\", \"class\": \"$player_status\", \"alt\": \"$player_status\", \"tooltip\": \"$text\"}"
else
    echo "{\"text\": \"Not playing\", \"class\": \"stopped\", \"alt\": \"stopped\", \"tooltip\": \"Spotify not running\"}"
fi
