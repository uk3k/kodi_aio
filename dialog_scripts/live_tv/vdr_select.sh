#!/bin/bash
#enable live-tv support

input=`whiptail --backtitle "$headline" \
        --title "Enable Live-TV" \
        --yesno "\nInstall VDR to enable Live-TV support and tv-recording features? \n\n " 15 100 \`
if [ "$input" = "0" ]
  then
    tv_vdr="true"
  else
    tv_vdr="false"
fi
