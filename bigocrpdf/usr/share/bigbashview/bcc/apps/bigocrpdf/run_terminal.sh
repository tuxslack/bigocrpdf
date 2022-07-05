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

    #Support multi pdf
    if [ "$(cat ~/.config/bigocrpdf/selected-file | wc -l)" -gt "1" ]; then

        for File  in $(cat ~/.config/bigocrpdf/selected-file); do
        
        FOLDER="$(dirname "$File")"
        FILENAME="$(basename "$File" | sed 's|\.pdf$||gI;s|\.jpg$||gI;s|\.jpeg$||gI;s|\.png$||gI;s| -ocr.pdf|-ocr.pdf|g')"
        if [ ! -w "$FOLDER" ]
        then
            FOLDER="$HOME"
        fi

        if [[ -e "${FOLDER}/${FILENAME}-ocr.pdf" || -L "${FOLDER}/${FILENAME}-ocr.pdf" ]] ; then
            i=2
            while [[ -e "${FOLDER}/${FILENAME}-ocr${i}.pdf" || -L "${FOLDER}/${FILENAME}-ocr${i}.pdf" ]] ; do
                let i++
            done
                SAVEFILE="${FOLDER}/${FILENAME}-ocr${i}.pdf"
            else
                SAVEFILE="${FOLDER}/${FILENAME}-ocr.pdf"
        fi
        
        
            ocrmypdf --force-ocr -l "$(cat ~/.config/bigocrpdf/lang)" $(cat ~/.config/bigocrpdf/align) --optimize "$(cat ~/.config/bigocrpdf/quality)" --sidecar "$HOME/.config/bigocrpdf/text.txt" "$File" "$SAVEFILE"
            echo "FILE $File   e    $SAVEFILE"
        done

    else

        ocrmypdf --force-ocr -l "$(cat ~/.config/bigocrpdf/lang)" $(cat ~/.config/bigocrpdf/align) --optimize "$(cat ~/.config/bigocrpdf/quality)" --sidecar "$HOME/.config/bigocrpdf/text.txt" "$(cat ~/.config/bigocrpdf/selected-file)" "$(cat ~/.config/bigocrpdf/savefile)"

    fi

fi
    
 if [ "$(xwininfo -id $WINDOW_ID 2>&1 | grep -i "No such window")" != "" ]; then
     kill -9 $PID
     exit 0
 fi

