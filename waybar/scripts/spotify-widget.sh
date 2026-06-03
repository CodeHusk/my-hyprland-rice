#!/bin/bash

status=$(playerctl -p spotify status 2>/dev/null)
artist=$(playerctl -p spotify metadata xesam:artist 2>/dev/null)
title=$(playerctl -p spotify metadata xesam:title 2>/dev/null)
position=$(playerctl -p spotify metadata xesam:position 2>/dev/null)
length=$(playerctl -p spotify metadata mpris:length 2>/dev/null)

if [[ -z "$status" || "$status" == "Stopped" ]]; then
    echo '{"text": "", "tooltip": "No music playing", "alt": "stopped"}'
    exit 0
fi

# Scrolling text
text="  $artist - $title  "
max_width=30
step=2

if [ ${#text} -le $max_width ]; then
    display_text="$text"
else
    tmpfile="/tmp/spotify_scroll_offset"
    offset=0
    [ -f "$tmpfile" ] && offset=$(cat "$tmpfile")
    double="${text}${text}"
    display_text="${double:$offset:$max_width}"
    offset=$(( (offset + step) % ${#text} ))
    echo "$offset" > "$tmpfile"
fi

# Progress bar for tooltip
PROGRESS_WIDTH=20
if [[ -n "$position" && -n "$length" && "$length" -gt 0 ]]; then
    percent=$((100 * position / length))
    filled=$((PROGRESS_WIDTH * percent / 100))
    empty=$((PROGRESS_WIDTH - filled))
    bar="[$(printf '%*s' "$filled" | tr ' ' '=')$(printf '%*s' "$empty" | tr ' ' ' ')]"
    tooltip="$artist - $title\n$bar $percent%"
else
    tooltip="$artist - $title"
fi

printf '{"text": "%s", "tooltip": "%s", "alt": "%s"}' "$display_text" "$tooltip" "$status"
