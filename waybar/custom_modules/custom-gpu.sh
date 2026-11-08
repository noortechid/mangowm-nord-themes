#!/bin/bash

GPU="/sys/class/drm/card0"

read_value() {
    cat "$GPU/$1" 2>/dev/null
}

CURRENT=$(read_value gt_cur_freq_mhz)
ACTIVE=$(read_value gt_act_freq_mhz)
MAX=$(read_value gt_max_freq_mhz)

if [[ "$CURRENT" =~ ^[0-9]+$ ]]; then
    CLOCK=$(awk "BEGIN {printf \"%.2f\", $CURRENT/1000}")
else
    CLOCK="N/A"
fi

jq -cn \
    --arg text "   ${CLOCK}GHz" \
    --arg tooltip "Intel HD Graphics 520\nDriver: i915\nCurrent: ${CURRENT:-N/A} MHz\nActive: ${ACTIVE:-N/A} MHz\nMaximum: ${MAX:-N/A} MHz" \
    '{text:$text,class:"custom-gpu",tooltip:$tooltip}'
