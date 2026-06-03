#!/bin/bash

# ── Wallpaper list ────────────────────────────────────────────
WALLPAPERS=(
    "/home/rudransh/Pictures/wallhaven-poyyjj.png"
   "/home/rudransh/Pictures/gargantua-black-3840x2160-9621.jpg"
   "/home/rudransh/Pictures/miyamoto-musashi-3840x2160-15204.jpg"
   "/home/rudransh/Pictures/hello-world-pixel-3840x2160-15168.png"
   "/home/rudransh/Pictures/full-moon-forest-night-dark-starry-sky-5k-8k-3840x2160-1684.jpg"
   "/home/rudransh/Pictures/your-name-shooting-3840x2160-14938.jpg"
   "/home/rudransh/Pictures/wallhaven-8grwv1.jpg"
)

STATE_FILE="$HOME/.config/hypr/wallpaper_index"

# ── Read current index ────────────────────────────────────────
if [[ -f "$STATE_FILE" ]]; then
    INDEX=$(cat "$STATE_FILE")
    if ! [[ "$INDEX" =~ ^[0-9]+$ ]]; then
        INDEX=0
    fi
else
    INDEX=0
fi

TOTAL=${#WALLPAPERS[@]}
NEXT_INDEX=$(( (INDEX + 1) % TOTAL ))
NEXT_WALL="${WALLPAPERS[$NEXT_INDEX]}"

# ── Transition picker (wofi) ──────────────────────────────────
TRANSITION=$(printf "  Left\n  Right\n  Top\n  Bottom\n  Wipe\n  Wave\n  Grow\n  Outer\n  Center\n  Simple\n  Any\n  Random\n  None" | \
    wofi --dmenu --lines 13 --width 300 --height 380 --location top_right --prompt "Transition")

case "$TRANSITION" in
    "  Left")
        AWWW_ARGS="--transition-type left --transition-fps 60 --transition-duration 1.5"
        ;;
    "  Right")
        AWWW_ARGS="--transition-type right --transition-fps 60 --transition-duration 1.5"
        ;;
    "  Top")
        AWWW_ARGS="--transition-type top --transition-fps 60 --transition-duration 1.5"
        ;;
    "  Bottom")
        AWWW_ARGS="--transition-type bottom --transition-fps 60 --transition-duration 1.5"
        ;;
    "  Wipe")
        AWWW_ARGS="--transition-type wipe --transition-angle 45 --transition-fps 60 --transition-duration 1.5"
        ;;
    "  Wave")
        AWWW_ARGS="--transition-type wave --transition-angle 45 --transition-fps 60 --transition-duration 1.5"
        ;;
    "  Grow")
        AWWW_ARGS="--transition-type grow --transition-pos 0.5,0.5 --transition-fps 60 --transition-duration 1.5"
        ;;
    "  Outer")
        AWWW_ARGS="--transition-type outer --transition-pos 0.5,0.5 --transition-fps 60 --transition-duration 1.5"
        ;;
    "  Center")
        AWWW_ARGS="--transition-type center --transition-pos 0.5,0.5 --transition-fps 60 --transition-duration 1.5"
        ;;
    "  Simple")
        AWWW_ARGS="--transition-type simple --transition-fps 60 --transition-duration 1.0"
        ;;
    "  Any")
        AWWW_ARGS="--transition-type any --transition-fps 60 --transition-duration 1.5"
        ;;
    "  Random")
        AWWW_ARGS="--transition-type random --transition-fps 60 --transition-duration 1.5"
        ;;
    "  None")
        AWWW_ARGS="--transition-type none"
        ;;
    *)  # default if nothing chosen
        AWWW_ARGS="--transition-type grow --transition-pos 0.5,0.5 --transition-fps 60 --transition-duration 1.5"
        ;;
esac

# ── Apply wallpaper ───────────────────────────────────────────
awww img "$NEXT_WALL" $AWWW_ARGS

# ── Save new index ────────────────────────────────────────────
echo "$NEXT_INDEX" > "$STATE_FILE"
