#!/bin/bash
#determine the selected smart-card-reader's usb-port
#works actually only for smargo
#V1.0.0.0.A


if [ "$(lsusb | grep "Future Technology")" ]
  then
    tv_cr_busid=$(lsusb | grep "Future Technology" | awk -v OFS=':' '{print $2,$4}' | sed s/://2)
    tv_cardreader="Smargo"
  else
    tv_cr_busid="000:000"
    tv_cardreader="None"
fi
if [ "$tv_cardreader" != "Smargo" ] 
  then    
    tv_cr_busid="000:000"
    tv_oscam="false"
    tv_prefcg_oscam="false"
    tv_provider="None"
    tv_cardreader="None"
fi
