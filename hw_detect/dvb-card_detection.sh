#!/bin/bash
#check if any dvb-card is already working
#V1.0.0.0.A

if [ -n "$(ls /dev/dvb/ | grep ^adapter.*)" ]
  then
    tv_vdr="true" 
fi
