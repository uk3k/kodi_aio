#!/bin/bash
#enable pay-tv descrambling (OSCAM)

if [ "$tv_vdr" = "true" ]
  then
    input=`whiptail --backtitle "$headline" \
            --title "Install OCAM" \
            --yesno "\nInstall OSCAM to descramble Pay-/HD-TV? \n\n " 15 100 2 \`
    if [ "$input" = "0" ]
      then
        tv_oscam="true"
    fi
  else
    tv_oscam="false"
fi
