#!/bin/bash
#enable live-tv support

if (whiptail --backtitle "$headline" \
            --title "Install VDR" \
            --yesno "\nDo you want to install Live-TV support? \n\n " 15 100)
      then
        tv_vdr="true"
      else
        tv_vdr="false"
fi

