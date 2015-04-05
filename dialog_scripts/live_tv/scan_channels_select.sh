#!/bin/bash
#scan for available TV-Channels

if [ "$tv_vdr" = "true" ] && [ "$tv_dvb_type" != "None" ] && [ "$tv_prompt_scan" = "true" ]
  then
    if (whiptail --backtitle "$headline" \
          --title "Scan for TV-Channels" \
          --yesno "\nDo you want to automatically scan for all available TV-Channels? \n\n " 15 100)
      then
        tv_scan="true"
      else
        tv_scan="false"
    fi
  else
    tv_scan="false"
fi
