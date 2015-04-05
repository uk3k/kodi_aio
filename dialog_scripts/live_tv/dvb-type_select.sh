#!/bin/bash
#select dvb-type for system

if [ "$tv_vdr" = "true" ]
  then
    input=`whiptail --backtitle "$headline" \
        --title "Setup mode" \
        --menu "\nSelect your broadcasting system/TV-Card type: \n\n " 30 100 2 \
                "DVB-T"       ""	\
                "DVB-S"       ""	\
                "DVB-C"       ""  3>&1 1>&2 2>&3`
    case $input in
      DVB-T)  tv_dvb_type="T";;
      DVB-S)  tv_dvb_type="T";;
      DVB-C)  tv_dvb_type="C";;
    esac
  else
    tv_dvb_type="None"
fi
