#!/bin/bash
CHOICE=$(printf "  Power Saver\n Balanced\n Performance" | wofi --dmenu --lines 3 --width 280 --height 130 --location top_right --prompt "Power")
case "$CHOICE" in
    "  Power Saver") powerprofilesctl set power-saver ;;
    " Balanced")   powerprofilesctl set balanced ;;
    " Performance") powerprofilesctl set performance ;;
esac
pkill -SIGRTMIN+12 waybar
