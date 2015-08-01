#!/bin/bash
#enable pay-tv descrambling (OSCAM)

if [ "$tv_vdr" = "true" ]
  then
    if (whiptail --backtitle "$headline" \
            --title "Install OCAM" \
            --yesno "\nInstall OSCAM to descramble Pay-/HD-TV? \n\n " 15 100)
      then
        tv_oscam="true"
        tv_precfg_oscam="true"
      else
        tv_oscam="false"
        tv_precfg_oscam="false"
    fi
  else
    tv_oscam="false"
    tv_precfg_oscam="false"
fi
