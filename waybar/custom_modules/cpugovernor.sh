#!/bin/bash

GOVERNOR=$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor 2>/dev/null)

case "$GOVERNOR" in
    performance)
        echo '{"text":"perf","class":"performance","tooltip":"CPU Governor: Performance"}'
        ;;
    schedutil)
        echo '{"text":"sched","class":"schedutil","tooltip":"CPU Governor: Schedutil"}'
        ;;
    *)
        echo "{\"text\":\"${GOVERNOR:-unknown}\",\"class\":\"unknown\",\"tooltip\":\"CPU Governor: ${GOVERNOR:-unknown}\"}"
        ;;
esac

