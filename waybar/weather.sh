#!/bin/bash
# Simple weather module for Waybar (wttr.in)
# Fetches temperature and condition; shows  icon + temp.

LOCATION="Kusmara"          # Change to your city if you like
FORMAT="%t"               # only temperature, e.g. "+27°C"

# Get weather data with timeout
RESPONSE=$(curl -s --connect-timeout 5 "wttr.in/${LOCATION}?format=${FORMAT}")

if [[ -z "$RESPONSE" ]]; then
    echo '{"text": " N/A", "tooltip": "Weather unavailable"}'
else
    # Clean up and keep only the temperature string
    TEMP=$(echo "$RESPONSE" | tr -d '[:space:]')
    echo "{\"text\": \" ${TEMP}\", \"tooltip\": \"Weather in ${LOCATION}: ${TEMP}\"}"
fi
