#!/bin/bash
#determine the selected smart-card-reader's usb-port
#works actually only for smargo
#V1.0.0.0.A


if [ "$(lsusb | grep "Future Technology")" ]
  then
    tv_cr_busid=$(lsusb | grep "Future Technology" | awk -v OFS=':' '{print $2,$4}' | sed s/://2)
    tv_cardreader="Smargo"
    tv_prefcg_oscam="true"
  else
    tv_cr_busid="No CR present"
    tv_cardreader="None"
    tv_prefcg_oscam="false"
fi
if [ "$tv_cardreader" != "Smargo" ] 
  then    
    tv_cr_busid="No CR present"
    tv_oscam="false"
    tv_prefcg_oscam="false"
    tv_provider="None"
    tv_cardreader="None"
fi
