#!/bin/bash

ART_FILE="/tmp/spotify-popup-art.jpg"

status=$(playerctl -p spotify status 2>/dev/null)
artist=$(playerctl -p spotify metadata xesam:artist 2>/dev/null)
title=$(playerctl -p spotify metadata xesam:title 2>/dev/null)
art_url=$(playerctl -p spotify metadata mpris:artUrl 2>/dev/null)

# Download album art
if [ -n "$art_url" ]; then
    if [[ "$art_url" == file://* ]]; then
        cp "${art_url#file://}" "$ART_FILE"
    else
        curl -s -o "$ART_FILE" "$art_url"
    fi
fi

prompt="$artist - $title [$status]"

options=(
    "󰐎  Play/Pause"
    "󰒭  Next"
    "󰒮  Previous"
    "󰔡  Show Album Art"
    "󰈆  Quit Pop‑up"
)

selected=$(printf '%s\n' "${options[@]}" | wofi \
    --dmenu \
    --prompt "$prompt" \
    --height 250 \
    --width 350 \
    --location center \
    --style ~/.config/wofi/spotify-popup.css)

case "$selected" in
    *Play/Pause*) playerctl -p spotify play-pause ;;
    *Next*)       playerctl -p spotify next ;;
    *Previous*)   playerctl -p spotify previous ;;
    *"Show Album Art"*)
        [ -f "$ART_FILE" ] && feh --auto-zoom --borderless --title 'Album Art' "$ART_FILE" & ;;
    *Quit*)       exit 0 ;;
esac
