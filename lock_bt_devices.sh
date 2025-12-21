#!/bin/bash

PHONE_MAC="mac_address"
RSSI_THRESHOLD=-30
CHECK_INTERVAL=2

echo "Bluetooth RSSI lock running (threshold: $RSSI_THRESHOLD dBm)"

while true; do
    RSSI=$(hcitool rssi "$PHONE_MAC" 2>/dev/null | awk '{print $NF}')

    if [[ -z "$RSSI" ]]; then
        echo "$(date) RSSI unavailable"
    elif (( RSSI <= RSSI_THRESHOLD )); then
        echo "$(date) RSSI=$RSSI → LOCK"
        cinnamon-screensaver-command -l
        sleep 15   # prevent lock spam
    else
        echo "$(date) RSSI=$RSSI → OK"
    fi

    sleep "$CHECK_INTERVAL"
done
