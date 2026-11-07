#!/bin/bash

PLAYER=$(playerctl -l 2>/dev/null | head -n1)

if [[ -z "$PLAYER" ]]; then
    jq -cn '{text:"",class:"stopped",tooltip:"No active player"}'
    exit 0
fi

STATUS=$(playerctl -p "$PLAYER" status 2>/dev/null)
TRACK=$(playerctl -p "$PLAYER" metadata --format '{{artist}} - {{title}}' 2>/dev/null)

[[ -z "$TRACK" ]] && TRACK="Unknown track"

jq -cn \
    --arg text "$TRACK" \
    --arg alt "$PLAYER" \
    --arg tooltip "$PLAYER | $STATUS" \
    '{text:$text,alt:$alt,tooltip:$tooltip,class:"media"}'

