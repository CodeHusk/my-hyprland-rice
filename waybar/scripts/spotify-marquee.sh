#!/bin/bash

status=$(playerctl status 2>/dev/null)
artist=$(playerctl metadata artist 2>/dev/null)
title=$(playerctl metadata title 2>/dev/null)

if [[ "$status" != "Playing" && "$status" != "Paused" ]]; then
  echo '{"text": ""}'
  exit 0
fi

text="  $artist - $title  "
max_width=40
step=2

if [ ${#text} -le $max_width ]; then
  printf '{"text": "%s"}' "$text"
  exit 0
fi

tmpfile="/tmp/spotify_scroll_offset"
offset=0
[ -f "$tmpfile" ] && offset=$(cat "$tmpfile")

double="${text}${text}"
scrolled="${double:$offset:$max_width}"

printf '{"text": "%s"}' "$scrolled"

offset=$(((offset + step) % ${#text}))
echo "$offset" >"$tmpfile"
