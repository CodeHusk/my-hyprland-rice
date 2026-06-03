#!/bin/bash
STATUS=$(playerctl status 2>/dev/null)
if [[ "$STATUS" == "Playing" || "$STATUS" == "Paused" ]]; then
    ARTIST=$(playerctl metadata artist 2>/dev/null)
    TITLE=$(playerctl metadata title 2>/dev/null)
    if [[ -n "$ARTIST" && -n "$TITLE" ]]; then
        TEXT=" $ARTIST - $TITLE"
    else
        TEXT=" $TITLE"
    fi
    echo "{\"text\": \"$TEXT\", \"tooltip\": \"$TEXT\", \"class\": \"playing\"}"
else
    echo "{\"text\": \"\", \"tooltip\": \"\", \"class\": \"\"}"
fi
