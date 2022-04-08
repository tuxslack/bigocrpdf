#!/bin/bash

#Author Bruno Goncalves  <www.biglinux.com.br>
#License: GPLv2 or later                       
#################################################


PID="$$" MARGIN_TOP_MOVE="-90" WINDOW_HEIGHT=12 WINDOW_ID="$WINDOW_ID" ./run_terminal_resize.sh &


if [ "$(grep '.pdf' ~/.config/bigocrpdf/selected-file)" = "" ]; then
#IMAGES
    img2pdf $(cat ~/.config/bigocrpdf/selected-file) | ocrmypdf --image-dpi 300 --force-ocr -l "$(cat ~/.config/bigocrpdf/lang)" $(cat ~/.config/bigocrpdf/align) --optimize "$(cat ~/.config/bigocrpdf/quality)" --sidecar "$HOME/.config/bigocrpdf/text.txt" - "$(cat ~/.config/bigocrpdf/savefile)"
else
# PDF
OIFS=$IFS
IFS=$'\n'
    ocrmypdf --force-ocr -l "$(cat ~/.config/bigocrpdf/lang)" $(cat ~/.config/bigocrpdf/align) --optimize "$(cat ~/.config/bigocrpdf/quality)" --sidecar "$HOME/.config/bigocrpdf/text.txt" "$(cat ~/.config/bigocrpdf/selected-file)" "$(cat ~/.config/bigocrpdf/savefile)"
fi


    
if [ "$(xwininfo -id $WINDOW_ID 2>&1 | grep -i "No such window")" != "" ]; then
    kill -9 $PID
    exit 0
fi

