#!/bin/bash
#check if any dvb-card is already working
#V1.0.0.0.A

if [ -n "$(ls /dev/dvb/ | grep ^adapter.*)" ]
  then
    tv_card_present="true"
    tv_vdr="true" 
  else
    tv_card_present="false"
    tv_vdr="false"
fi
