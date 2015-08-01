#!/bin/bash
#check if any dvb-card is already working
#V1.0.0.0.A

if [ -n "$(ls /dev/dvb/ | grep ^adapter.*)" ]
  then
    tv_vdr="true" 
    tv_oscam="true"
    tv_prefcg_oscam="true"
    tv_provider="KBW"
    tv_cardreader="Smargo"
    tv_prompt_scan="true"
  else
    tv_vdr="false" 
    tv_oscam="false"
    tv_prompt_scan="false"
    tv_prefcg_oscam="true"
    tv_provider="None"
    tv_cardreader="None"
    tv_prompt_scan="false"
    tv_scan="false"
fi
