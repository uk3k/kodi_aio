#!/bin/bash
#use predefined settings for paytv provider

if [ "$tv_vdr" = "true" ] && [ "$tv_oscam" = "true" ] && [ "$tv_cardreader" != "None" ]
  then
    input=`whiptail --backtitle "$headline" \
        --title "Pay-TV Provider" \
        --menu "\nSelect your Pay-/HD-TV provider: \n\n " 30 100 5 \
                "UM"        "Unity Media"	        \
                "KBW"       "KabelBW"	            \
                "KD"        "Kabel Deutschland"   \
                "HD Plus"   "HD+"                 \
                "SKY"       "SKY Deutschland" 3>&1 1>&2 2>&3`
    case $input in
      UM)       tv_provider="UM"      ;;
      KBW)      tv_provider="KBW"     ;;
      KD)       tv_provider="KD"      ;;
      HD Plus)  tv_provider="HDPlus"  ;;
      SKY)      tv_provider="SKY"     ;;
    esac
  else
    tv_provider="None"
fi
