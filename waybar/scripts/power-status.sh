#!/bin/bash
PROFILE=$(powerprofilesctl get)
case "$PROFILE" in
    "power-saver")   ICON=""  ;;
    "balanced")      ICON=""  ;;
    "performance")   ICON=""  ;;
    *)               ICON=""  ;;
esac
echo "{\"text\": \"$ICON  $PROFILE\", \"tooltip\": \"Click to change power profile\", \"class\": \"$PROFILE\"}"
