#!/bin/bash

#Author Bruno Goncalves  <www.biglinux.com.br>
#License: GPLv2 or later                       
#################################################


PID="$$" WINDOW_ID="$WINDOW_ID" ./run_terminal_resize.sh &

OIFS=$IFS
IFS=$'\n'

    ocrmypdf --threshold -l "$(cat ~/.config/bigocrpdf/lang)" --optimize "$(cat ~/.config/bigocrpdf/quality)" "$(cat ~/.config/bigocrpdf/selected-file)" "$(cat ~/.config/bigocrpdf/savefile)" 


if [ "$(xwininfo -id $WINDOW_ID 2>&1 | grep -i "No such window")" != "" ]; then
    kill -9 $PID
    exit 0
fi

IFS=$OIFS
