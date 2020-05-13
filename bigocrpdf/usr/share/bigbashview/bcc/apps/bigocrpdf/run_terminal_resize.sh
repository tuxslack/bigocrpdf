#!/bin/bash

#Author Bruno Goncalves  <www.biglinux.com.br>
#License: GPLv2 or later                       
#################################################


STOP=0
while [  "$STOP" = "0" ]; do

    WINDOW_HEIGHT="17"
    WINDOW_WIDTH="$(xwininfo -id $WINDOW_ID | grep Width: | sed 's|.* ||g')"
    WIDTH_TERMINAL="$(echo "$WINDOW_WIDTH * 0.7143 / 10" | bc | cut -f1 -d".")"
    MARGIN_LEFT="$(echo "$WINDOW_WIDTH * 0.14" | bc | cut -f1 -d".")"
    MARGIN_TOP="160"
    xtermset -geom ${WIDTH_TERMINAL}x${WINDOW_HEIGHT}+${MARGIN_LEFT}+${MARGIN_TOP}
    sleep 1
    
    # if close bigbashview window, kill terminal too
    if [ "$(xwininfo -id $WINDOW_ID 2>&1 | grep -i "No such window")" != "" ]; then
        kill -9 $PID
        exit 0
    fi
    
    
done
