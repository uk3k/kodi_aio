#!/bin/bash
#enable live-tv support

if (whiptail --backtitle "$headline" \
            --title "Install VDR" \
            --yesno "\nDo you want to install Live-TV support? \n\n " 15 100)
      then
        tv_vdr="true"
        tv_prompt_scan="true"
      else
        tv_vdr="false"
        tv_prompt_scan="false"
fi

